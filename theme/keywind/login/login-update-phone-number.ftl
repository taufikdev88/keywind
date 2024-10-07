<#import "template.ftl" as layout>

<#import "components/atoms/alert.ftl" as alert>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>

<@layout.registrationLayout
  script="dist/phoneNumberVerificationCode.js"
  displayInfo=true; section>

  <#--  HEADER SECTION  -->
  <#if section = "header">
    ${msg("updatePhoneNumber")}
  <#--  FORM SECTION  -->
  <#elseif section = "form">
    <@form.kw action=url.loginAction method="post">
      <div
        x-data="phoneVerification"
        data-default-send-button-text="${msg('sendVerificationCode')}"
        data-default-required-phone-number-text="${msg('requiredPhoneNumber')}"
        data-realm-name="${realm.name}"
        data-token-code-type="verification-code"
      >
        <#--  alert message  -->
        <div x-show="errorMessage">
          <#--  alert for internal server error  -->
          <@alert.kw color="error">
            <span x-text="errorMessage"></span>
          </@alert.kw>
        </div>

        <#--  phone number  -->
        <@input.kw
          type="tel"
          id="phoneNumber"
          name="phoneNumber"
          model="phoneNumber"
          label=msg("phoneNumber")
          autocomplete="mobile tel"
        />

        <#--  code verification  -->
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

        <#--  credential input hidden  -->
        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>

        <#--  button submit  -->
        <@buttonGroup.kw>
          <@button.kw color="primary" type="submit">
            ${msg("doSubmit")}
          </@button.kw>
        </@buttonGroup.kw>
      </div>
    </@form.kw>
  </#if>
</@layout.registrationLayout>
