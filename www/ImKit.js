function ImKit() {
};

ImKit.prototype.init = function (success, error) {
  cordova.exec(success, error, 'ImKit', 'init', []);
}
ImKit.prototype.connect = function (str, str2, str3, success, error) {
  cordova.exec(success, error, 'ImKit', 'connect', [str,str2,str3]);
}
ImKit.prototype.launchCustomer = function (str1, str2, success, error) {
  cordova.exec(success, error, 'ImKit', 'launchCustomer', [str1,str2]);
}

ImKit.install = function () {
  if (!window.plugins) {
    window.plugins = {};
  }
  window.plugins.ImKit = new ImKit();
  return window.plugins.ImKit;
};

cordova.addConstructor(ImKit.install);
