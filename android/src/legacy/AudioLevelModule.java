package com.reactnativeaudiolevel;

import androidx.annotation.NonNull;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class AudioLevelModule extends ReactContextBaseJavaModule {
  public static final String NAME = AudioLevelModuleImpl.NAME;

  AudioLevelModule(ReactApplicationContext context) {
    super(context);
  }

  @Override
  @NonNull
  public String getName() {
    return AudioLevelModuleImpl.NAME;
  }

  // Example method
  // See https://reactnative.dev/docs/native-modules-android
  @ReactMethod
  public void multiply(double a, double b, Promise promise) {
    AudioLevelModuleImpl.multiply(a, b, promise);
  }
}
