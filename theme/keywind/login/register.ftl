<#import "template.ftl" as layout>
<#import "components/atoms/alert.ftl" as alert>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>

<#if phoneNumberRequired??>
  <#assign scriptSrc>dist/phoneNumberVerificationCode.js</#assign>
</#if>

<@layout.registrationLayout
  script=scriptSrc
  displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm','phoneNumber','registerCode'); section>

  <#--  HEADER SECTION  -->
  <#if section="header">
    ${msg("registerTitle")}
  <#--  FORM SECTION  -->
  <#elseif section="form">
    <@form.kw action=url.registrationAction method="post">
      <div
        <#if phoneNumberRequired??>
          x-data="phoneVerification"
          data-default-send-button-text="${msg('sendVerificationCode')}"
          data-default-required-phone-number-text="${msg('requiredPhoneNumber')}"
          data-realm-name="${realm.name}"
          data-token-code-type="registration-code"
        </#if>>

        <#--  error message if exist  -->
        <#if phoneNumberRequired??>
          <div x-show="errorMessage">
            <#--  alert for internal server error  -->
            <@alert.kw color="error">
              <span x-text="errorMessage"></span>
            </@alert.kw>
          </div>
        </#if>

        <#if !hideName??>
          <#--  given name form  -->
          <@input.kw
            autocomplete="given-name"
            autofocus=true
            invalid=messagesPerField.existsError("firstName")
            label=msg("firstName")
            message=kcSanitize(messagesPerField.get("firstName"))
            name="firstName"
            type="text"
            value=(register.formData.firstName)!''
          />
          <#--  family name  -->
          <@input.kw
            autocomplete="family-name"
            invalid=messagesPerField.existsError("lastName")
            label=msg("lastName")
            message=kcSanitize(messagesPerField.get("lastName"))
            name="lastName"
            type="text"
            value=(register.formData.lastName)!''
          />
        </#if>

        <#if !hideEmail??>
          <#--  email  -->
          <@input.kw
            autocomplete="email"
            invalid=messagesPerField.existsError("email")
            label=msg("email")
            message=kcSanitize(messagesPerField.get("email"))
            name="email"
            type="email"
            value=(register.formData.email)!''
          />
        </#if>

        <#if !(realm.registrationEmailAsUsername || registrationPhoneNumberAsUsername??)>
          <#--  username  -->
          <@input.kw
            autocomplete="username"
            invalid=messagesPerField.existsError("username")
            label=msg("username")
            message=kcSanitize(messagesPerField.get("username"))
            name="username"
            type="text"
            value=(register.formData.username)!''
          />
        </#if>

        <#if passwordRequired??>
          <#--  password  -->
          <@input.kw
            autocomplete="new-password"
            invalid=messagesPerField.existsError("password", "password-confirm")
            label=msg("password")
            message=kcSanitize(messagesPerField.getFirstError("password", "password-confirm"))
            name="password"
            type="password"
          />
          <#--  password confirm  -->
          <@input.kw
            autocomplete="new-password"
            invalid=messagesPerField.existsError("password-confirm")
            label=msg("passwordConfirm")
            message=kcSanitize(messagesPerField.get("password-confirm"))
            name="password-confirm"
            type="password"
          />
        </#if>

        <#if phoneNumberRequired??>
          <#--  phone number  -->
          <@input.kw
            type="tel"
            id="phoneNumber"
            name="phoneNumber"
            model="phoneNumber"
            label=msg("phoneNumber")
            autocomplete="mobile tel"
            invalid=messagesPerField.existsError('phoneNumber')
            message=kcSanitize(messagesPerField.get("phoneNumber"))
            value=(register.formData.phoneNumber)!''
          />

          <#if verifyPhone??>
            <div class="flex flex-row">
              <div class="basis-3/4 mr-4">
                <@input.kw
                  tabindex=0
                  type="text"
                  id="code"
                  label=msg("verificationCode")
                  name="code"
                  invalid=messagesPerField.existsError('registerCode')
                  message=kcSanitize(messagesPerField.get('registerCode'))
                  autocomplete="one-time-code"
                />
              </div>
              <div class="basis-1/4">
                <@input.kw
                  tabindex=0
                  class="btn block mt-1 py-2 bg-primary-600 hover:bg-primary-700 w-full text-white rounded sm:text-sm"
                  type="button"
                  model="sendButtonText"
                  click="sendVerificationCode"
                  disabled_function="sendButtonText !== initSendButtonText"
                />
              </div>
            </div>
          </#if>
        </#if>

        <#if recaptchaRequired??>
          <#--  rechapta  -->
          <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-size="compact"></div>
        </#if>

        <@buttonGroup.kw>
          <#--  submit button  -->
          <@button.kw color="primary" type="submit">
            ${msg("doRegister")}
          </@button.kw>
        </@buttonGroup.kw>
      </div>
    </@form.kw>
  <#--  NAV SECTION  -->
  <#elseif section="nav">
    <#--  back to login button  -->
    <@link.kw color="secondary" href=url.loginUrl size="small">
      ${kcSanitize(msg("backToLogin"))?no_esc}
    </@link.kw>
  </#if>
</@layout.registrationLayout>
