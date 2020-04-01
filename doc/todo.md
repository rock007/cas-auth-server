
***不能加，加了会启动不了***
  # Forgot Username Email Info
  forgotUsername:
    mail:
      from: i_am_forget@163.com
      subject: 找回密码 Name
      replyTo: CAS@test.net
      html: false
      attributeName: userid

  # Password Management Database Connection Info
  jdbc:
    user: root
    password: 123456
    driverClass: com.mysql.cj.jdbc.Driver
    dialect: org.hibernate.dialect.MySQLDialect
    url: jdbc:mysql://127.0.0.1:3306/auth_center?autoReconnect=true&characterEncoding=utf-8&useUnicode=true&useSSL=false&serverTimezone=GMT
    #passwordEncoder.type: NONE

    # Queries Needed to Support PM functionality
    sqlSecurityQuestions=SELECT question, answer FROM sys_user_question WHERE user_id=?
    sqlFindEmail=SELECT email FROM sys_user WHERE user_id=?
    sqlFindPhone=SELECT phone FROM sys_user WHERE user_id=?
    sqlFindUser=SELECT userid FROM sys_user WHERE email=?
    sqlChangePassword=UPDATE sys_user SET password=?, expired=0 WHERE user_id=?
    
**services配置jwt 和秘钥，没成功 **    

  {
    "@class": "org.apereo.cas.support.oauth.services.OAuthRegisteredService",
    "clientId": "client",
    "clientSecret": "secret",
    "serviceId": "^(https|imaps)://.*",
    "name": "OAUTH",
    "jwtAccessToken": true,
    "id": 1,
    "attributeReleasePolicy": {
      "@class": "org.apereo.cas.services.ReturnAllowedAttributeReleasePolicy",
      "allowedAttributes": [ "java.util.ArrayList", [ "cn", "mail", "sn" ] ]
    },
    "supportedGrantTypes": [ "java.util.HashSet", [ "password" ] ],
    "properties": {
      "@class": "java.util.HashMap",
      "accessTokenAsJwtSigningKey": {
        "@class": "org.apereo.cas.services.DefaultRegisteredServiceProperty",
        "values": [ "java.util.HashSet", [ "ZHfrJF9JKTF3ee6pXZvFVSbgArhKIEGHk8zaErUJTZPhhjGh9Xjz_CGhtFDw7UKOmagZSX6KTSW4sd12C-jJfQ" ] ]
      },
      "accessTokenAsJwtEncryptionKey": {
        "@class": "org.apereo.cas.services.DefaultRegisteredServiceProperty",
        "values": [ "java.util.HashSet", [ "PMJEy6q6-1R029IYhnoI5Rm4ub66RQfxy8KDeXkG1_o" ] ]
      },
      "accessTokenAsJwtSigningEnabled": {
        "@class": "org.apereo.cas.services.DefaultRegisteredServiceProperty",
        "values": [ "java.util.HashSet", [ "true" ] ]
      },
      "accessTokenAsJwtEncryptionEnabled": {
        "@class": "org.apereo.cas.services.DefaultRegisteredServiceProperty",
        "values": [ "java.util.HashSet", [ "true" ] ]
      }
    }
  }
原来的配置:
{
    "@class" : "org.apereo.cas.support.oauth.services.OAuthRegisteredService",
    "clientId": "client",
    "clientSecret": "secret",
    "serviceId": "^(https|imaps)://.*",
    "name" : "OAUTH",
    "jwtAccessToken": true,
    "id" : 10009,
    "attributeReleasePolicy" : {
      "@class" : "org.apereo.cas.services.ReturnAllowedAttributeReleasePolicy",
      "allowedAttributes" : [ "java.util.ArrayList", [ "user_id","user_name", "phone", "email" ] ]
    },
    "supportedGrantTypes": [ "java.util.HashSet", [ "password" ] ]
  }