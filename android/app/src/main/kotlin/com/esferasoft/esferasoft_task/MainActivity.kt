package com.esferasoft.esferasoft_task
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import okhttp3.*
import okhttp3.MediaType.Companion.toMediaType
import org.json.JSONObject
import java.io.IOException

class MainActivity : FlutterActivity(){
    private val CHANNEL = "com.example.native/api"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "login") {
                val email = call.argument<String>("email")!!
                val password = call.argument<String>("password")!!
                val deviceToken = call.argument<String>("device_token")!!
                val deviceType = call.argument<String>("device_type")!!

                makeLoginRequest(email, password, deviceToken, deviceType, result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun makeLoginRequest(
        email: String,
        password: String,
        deviceToken: String,
        deviceType: String,
        result: MethodChannel.Result
    ) {
        val client = OkHttpClient()

        val json = JSONObject().apply {
            put("email", email)
            put("password", password)
            put("device_token", deviceToken)
            put("device_type", deviceType)
        }

        val body = RequestBody.create("application/json".toMediaType(), json.toString())

        val request = Request.Builder()
            .url("https://scratchy.esferasoft.in/api/login")
            .post(body)
            .build()

        client.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
                result.error("HTTP_ERROR", "Failed to call API", e.localizedMessage)
            }

            override fun onResponse(call: Call, response: Response) {
                val responseData = response.body?.string()
                activity.runOnUiThread {
                    result.success(responseData)
                }
            }
        })
    }
}
