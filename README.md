CAS Overlay Template [![Build Status](https://travis-ci.org/apereo/cas-overlay-template.svg?branch=master)](https://travis-ci.org/apereo/cas-overlay-template)
=======================

Generic CAS WAR overlay to exercise the latest versions of CAS. This overlay could be freely used as a starting template for local CAS war overlays.

# Versions

- CAS `6.2.x`
- JDK `11`

# Overview

To build the project, use:

```bash
# Use --refresh-dependencies to force-update SNAPSHOT versions
./gradlew[.bat] clean build
```

To see what commands are available to the build script, run:

```bash
./gradlew[.bat] tasks
```

To launch into the CAS command-line shell:

```bash
./gradlew[.bat] downloadShell runShell
```

To fetch and overlay a CAS resource or view, use:

```bash
./gradlew[.bat] getResource -PresourceName=[resource-name]
```

To list all available CAS views and templates:

```bash
./gradlew[.bat] listTemplateViews
```

To unzip and explode the CAS web application file and the internal resources jar:

```bash
./gradlew[.bat] explodeWar
```

# Configuration

- The `etc` directory contains the configuration files and directories that need to be copied to `/etc/cas/config`.

```bash
./gradlew[.bat] copyCasConfiguration
```

- The specifics of the build are controlled using the `gradle.properties` file.

## Adding Modules

CAS modules may be specified under the `dependencies` block of the [Gradle build script](build.gradle):

```gradle
dependencies {
    compile "org.apereo.cas:cas-server-some-module:${project.casVersion}"
    ...
}
```

To collect the list of all project modules and dependencies:

```bash
./gradlew[.bat] allDependencies
```

### Clear Gradle Cache

If you need to, on Linux/Unix systems, you can delete all the existing artifacts (artifacts and metadata) Gradle has downloaded using:

```bash
# Only do this when absolutely necessary
rm -rf $HOME/.gradle/caches/
```

Same strategy applies to Windows too, provided you switch `$HOME` to its equivalent in the above command.

# Deployment

- Create a keystore file `thekeystore` under `/etc/cas`. Use the password `changeit` for both the keystore and the key/certificate entries. This can either be done using the JDK's `keytool` utility or via the following command:

```bash
./gradlew[.bat] createKeystore
```

- Ensure the keystore is loaded up with keys and certificates of the server.

On a successful deployment via the following methods, CAS will be available at:

* `https://cas.server.name:8443/cas`

## Executable WAR

Run the CAS web application as an executable WAR:

```bash
./gradlew[.bat] run
```

Debug the CAS web application as an executable WAR:

```bash
./gradlew[.bat] debug
```

Run the CAS web application as a *standalone* executable WAR:

```bash
./gradlew[.bat] clean executable
```

## External

Deploy the binary web application file `cas.war` after a successful build to a servlet container of choice.

## Docker

The following strategies outline how to build and deploy CAS Docker images.

### Jib

The overlay embraces the [Jib Gradle Plugin](https://github.com/GoogleContainerTools/jib) to provide easy-to-use out-of-the-box tooling for building CAS docker images. Jib is an open-source Java containerizer from Google that lets Java developers build containers using the tools they know. It is a container image builder that handles all the steps of packaging your application into a container image. It does not require you to write a Dockerfile or have Docker installed, and it is directly integrated into the overlay.

```bash
./gradlew build jibDockerBuild
```

### Dockerfile

You can also use the native Docker tooling and the provided `Dockerfile` to build and run CAS.

```bash
chmod +x *.sh
./docker-build.sh
./docker-run.sh
```

**2020-03-31** 目标是可单点登录支持第三方无session认证(oauth)
1: explodeWar 把cas/build/cas-resources放到src/main/resources
2：admin/123456 密码不加密
3：jwt获取 http://localhost:8080/cas/oauth2.0/token?grant_type=password&client_id=client&client_secret=secret&username=admin&password=123456
4：帐号表（sys_user）登录以user_name为查询对象，找回密码问题（sys_user_question）应该用user_name而不是user_id，这个有问题，要做转换，最好代码实现这个功能；
5：生成的token为
{
    "access_token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.ZXlKNmFYQWlPaUpFUlVZaUxDSmhiR2NpT2lKa2FYSWlMQ0psYm1NaU9pSkJNVEk0UTBKRExVaFRNalUySWl3aVkzUjVJam9pU2xkVUlpd2lkSGx3SWpvaVNsZFVJbjAuLjdQT2tac2xNUUI1TTEtQTRxVm94bVEuYmJDQTBCWGVhbUNDNDBZdVhuLW1KMm1kUWVjaFFWNWV2SUpYMG9Wbk8wTHNPdXRCLWdORlNqM3Jib1c2djdrdzVKMUxOT00xR25pU1VGenlEY1kxRG51S25PQW96Um0wU0RmbWszclVibENicXJDbVFIUndkdUpBR2dpalZLczg1LXM0QVp0a003aGpndGtHaUd2VnhiSlFhV2NMVENDYUwxRTdLSnFsQTQ5UEZ1ZzYxVENVX1JwMXFvbDZwZHRYSTBqZ1dmN2hXc0RqU3dXZG1fdkt4eVZNcHhzd2k5MzdkWlloT24ySG9aQTRrd2tIWW03d3J5dFhkZU1TVnQwb3NBT3ZaMjN0aGpsajQtTWtkaHpMcnpqdjNCamlQY2hUTi01REdRNTk4Ty1Vb05zQndSdnJpT3V4YWVVT0VwcVgud3JJR0hXa2loRDl1VFFYSmJYUGRlZw.HbM3Q3dKhfafc8MJnLJn2hUYcdZdxi-dNkPUXfiuzU3wYOxeGANtQfr-uV3TxHhrwrp0tSI6wDXsxVnbHvsFnQ",
    "token_type": "bearer",
    "expires_in": 28800,
    "scope": ""
}
可转换成
{"sub":"admin","user_name":"admin","roles":[],"iss":"https:\/\/cas.example.org:8443\/cas","nonce":"","client_id":"client","aud":"client","grant_type":"PASSWORD","user_id":"1","permissions":[],"scope":[],"claims":[],"scopes":[],"state":"","exp":1585740764,"iat":1585711964,"jti":"AT-1-EqlI-LmNKFRoo4WlcpOFdrCe3alv4rUa","email":"huang.wenbin@foxmail.com"}
