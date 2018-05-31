package com.rong.imkit;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;

import android.content.Intent;
import android.content.Context;

import com.rongim.talk.BaseUtils;

public class ImKit extends CordovaPlugin {

  public static final String ACTION_INIT = "init";
  public static final String ACTION_CONNECT = "connect";
  public static final String ACTION_LAUNCH_CUSTOMER = "launchCustomer";

  private static CallbackContext mCallbackContext;
  private static CordovaInterface mCordova = null;
  private static CordovaPlugin mPlugin = null;

  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);
    mCordova = cordova;
    mPlugin = this;
  }

  public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
    if (ACTION_INIT.equals(action)) {
      BaseUtils.init(mCordova.getActivity(), callbackContext);
    } else if (ACTION_CONNECT.equals(action)) {
      String token = args.getString(0);
      BaseUtils.connect(mCordova.getActivity(), token, callbackContext);
    } else if (ACTION_LAUNCH_CUSTOMER.equals(action)) {
      String id = args.getString(0);
      BaseUtils.startCustomerServiceChat(mCordova.getActivity(), id, callbackContext);
    }
    return true;
  }
}
