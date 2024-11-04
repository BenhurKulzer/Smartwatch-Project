plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.protobuf")
}

android {
    namespace = "com.example.wearbear"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.wearbear"
        minSdk = 30
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
        vectorDrawables {
            useSupportLibrary = true
        }

    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
    buildFeatures {
        compose = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.1"
    }
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {
    implementation("io.grpc:grpc-stub")
    implementation("io.grpc:grpc-protobuf")
    implementation("io.grpc:grpc-okhttp")
    implementation("javax.annotation:javax.annotation-api")
    implementation("io.github.cdimascio:dotenv-kotlin:6.3.1")

    implementation("com.google.android.gms:play-services-wearable")
    implementation("com.google.accompanist:accompanist-swiperefresh:0.31.1-alpha")

    implementation("androidx.activity:activity-compose")
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.material:material")
    implementation(platform("androidx.compose:compose-bom"))
    implementation("androidx.core:core-splashscreen:1.0.1")
    implementation("androidx.lifecycle:lifecycle-viewmodel-ktx")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx")
    implementation("androidx.lifecycle:lifecycle-viewmodel-compose")
    implementation("androidx.navigation:navigation-compose")

    implementation("androidx.wear.compose:compose-material")
    implementation("androidx.wear.compose:compose-foundation")
    implementation("androidx.wear.compose:compose-navigation")
    implementation("androidx.wear.compose:compose-material3")

    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")
    implementation("com.squareup.okhttp3:logging-interceptor:4.9.1")

    androidTestImplementation(platform("androidx.compose:compose-bom"))
    androidTestImplementation("androidx.compose.ui:ui-test-junit4")
    debugImplementation("androidx.compose.ui:ui-tooling")
    debugImplementation("androidx.compose.ui:ui-test-manifest")
}
