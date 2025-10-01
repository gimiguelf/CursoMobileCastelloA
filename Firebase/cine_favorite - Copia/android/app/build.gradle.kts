// Pega o valor do versionCode e versionName que são definidos no pubspec.yaml
// Acessando as propriedades de maneira segura e convertendo para os tipos corretos (Int/String)
val flutterVersionCode: Int = project.property("flutter.versionCode")?.toString()?.toInt() ?: 1
val flutterVersionName: String = project.property("flutter.versionName") as String

plugins {
    // Adicione a linha do Google Services (Firebase) aqui, se ainda não estiver:
    id("com.google.gms.google-services") version "4.4.1" apply false
    alias(libs.plugins.androidApplication)
    alias(libs.plugins.kotlinAndroid)
}

android {
    namespace = "com.example.cine_favorite"
    compileSdk = 34 // Mantenha sua versão de compilação
    
    defaultConfig {
        // CORREÇÃO DE SINTAXE: Usando o operador de atribuição (=) em Kotlin DSL
        applicationId = "com.example.cine_favorite"
        
        // Corrigido de 'minSdkVersion 23' para 'minSdkVersion = 23'
        // Mantenha 23, que é o mínimo seguro para a maioria das dependências do Firebase.
        minSdkVersion = 23 
        
        // Corrigido de 'targetSdkVersion 34' para 'targetSdkVersion = 34'
        targetSdkVersion = 34
        
        // CORREÇÃO DE REFERÊNCIA: Usa as variáveis que definimos no topo do arquivo
        versionCode = flutterVersionCode
        versionName = flutterVersionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    implementation(libs.flutter.embedding.android)
    // Outras dependências, como as do Firebase, vão aqui.
}
