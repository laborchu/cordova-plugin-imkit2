package com.rongim.talk;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.telecom.Call;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.rongim.talk.http.HttpUtils;
import com.rongim.talk.module.activity.RongTabsActivity;

import java.util.ArrayList;
import java.util.List;

import io.rong.imkit.RongIM;
import io.rong.imlib.RongIMClient;
import io.rong.imlib.model.Conversation;
import io.rong.imlib.model.Message;
import io.rong.imlib.model.MessageContent;
import io.rong.imlib.model.UserInfo;
import io.rong.message.TextMessage;
import org.apache.cordova.*;
import io.rong.imlib.model.CSCustomServiceInfo;

/**
 * Created by jazzeZhou on 16/11/17.
 */
public class BaseUtils {

  public static CallbackContext chatCallbackContext = null;
  public static CallbackContext chatsCallbackContext = null;

  public static void init(Context context, final CallbackContext callbackContext) {
    RongIM.init(context);
    PluginResult pr = new PluginResult(PluginResult.Status.OK, "init");
    pr.setKeepCallback(true);
    callbackContext.sendPluginResult(pr);
    RongIM.setOnReceiveMessageListener(new RongIMClient.OnReceiveMessageListener() {
      @Override
      public boolean onReceived(Message message, int i) {
        PluginResult pr = new PluginResult(PluginResult.Status.OK, "msg");
        pr.setKeepCallback(true);
        callbackContext.sendPluginResult(pr);
        return false;
      }
    });
  }

  public static void connect(final Context context, String token, final CallbackContext callbackContext) {
    RongIM.getInstance().logout();
    RongIM.connect(token, new RongIMClient.ConnectCallback() {
      @Override
      public void onTokenIncorrect() {
        Log.i("connect", "onTokenIncorrect");
      }

      @Override
      public void onSuccess(String s) {
        Log.i("connect", "onSuccess:" + s);
        callbackContext.success("");
      }

      @Override
      public void onError(RongIMClient.ErrorCode errorCode) {
        callbackContext.error("");
      }
    });

  }

  public static void exit(Context context) {
    RongIM.getInstance().logout();
  }

  public static void startCustomerServiceChat(Activity context, String id, final CallbackContext callbackContext) {
    chatCallbackContext = callbackContext;
    RongIM.getInstance().startCustomerServiceChat(context, id, "在线客服", null);
  }

}
