<#import "template.ftl" as layout>
<#import "components/atoms/alert.ftl" as alert>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>
<#import "components/atoms/tabs-content.ftl" as tabsContent>
<#import "components/atoms/tabs-content-group.ftl" as tabsContentGroup>
<#import "components/atoms/tabs-header.ftl" as tabsHeader>
<#import "components/atoms/tabs-header-group.ftl" as tabsHeaderGroup>
<#import "features/labels/username.ftl" as usernameLabel>

<#assign usernameLabel><@usernameLabel.kw /></#assign>
<#if supportPhone??>
  <#assign scriptSrc>dist/phoneNumberVerificationCode.js</#assign>
</#if>

<@layout.registrationLayout
  script=scriptSrc
  displayInfo=true
  displayMessage=!messagesPerField.existsError("username"); section>

  <#--  HEADER SECTION  -->
  <#if section="header">
    ${msg("emailForgotTitle")}
  <#--  FORM SECTION  -->
  <#elseif section="form">
    <@form.kw action=url.loginAction method="post">
      <#--  show tab  -->
      <div
        <#if supportPhone??>
          x-data="phoneVerification"
          data-default-send-button-text="${msg('sendVerificationCode')}"
          data-default-required-phone-number-text="${msg('requiredPhoneNumber')}"
          data-realm-name="${realm.name}"
          data-token-code-type="reset-code"
        </#if>>

        <#if supportPhone??>
          <#--  error message  -->
          <div x-show="errorMessage">
            <#--  alert for internal server error  -->
            <@alert.kw color="error">
              <span x-text="errorMessage"></span>
            </@alert.kw>
          </div>
          <#--  tabs header  -->
          <@tabsHeaderGroup.kw>
            <@tabsHeader.kw name="username" selected="!phoneActivated" @click="phoneActivated = false">
              ${msg("usernameOrEmail")}
            </@tabsHeader.kw>
            <@tabsHeader.kw name="phone" selected="phoneActivated" @click="phoneActivated = true">
              ${msg("phoneNumber")}
            </@tabsHeader.kw>
          </@tabsHeaderGroup.kw>
        </#if>
        <#--  tabs content  -->
        <@tabsContentGroup.kw>
          <@tabsContent.kw name="username" hidden=supportPhone??>
            <#if supportPhone??>
              <template x-if="!phoneActivated">
            </#if>

            <@input.kw
              autocomplete=realm.loginWithEmailAllowed?string("email", "username")
              autofocus=true
              invalid=messagesPerField.existsError("username")
              label=usernameLabel
              message=kcSanitize(messagesPerField.get("username"))
              name="username"
              type="text"
              value=(auth?has_content && auth.showUsername())?then(auth.attemptedUsername, '')
            />

            <#if supportPhone??>
              </template>
            </#if>
          </@tabsContent.kw>
          <#if supportPhone??>
            <@tabsContent.kw name="phone">
              <template x-if="phoneActivated">
                <div>
                  <#--  input phone number  -->
                  <@input.kw
                    <#--  class="phone"  -->
                    tabindex=0
                    type="text"
                    id="phoneNumber"
                    name="phoneNumber"
                    model="phoneNumber"
                    label=msg("phoneNumber")
                    invalid=messagesPerField.existsError('code','phoneNumber')
                    message=kcSanitize(messagesPerField.getFirstError('phoneNumber','code'))?no_esc
                    autofocus=true
                    disabled=usernameEditDisabled??
                  />
                  <#--  input code with send button -->
                  <div class="flex flex-row">
                    <div class="basis-3/4 mr-4">
                      <@input.kw
                        tabindex=0
                        type="text"
                        id="code"
                        label=msg("verificationCode")
                        name="code"
                        invalid=messagesPerField.existsError('code','phoneNumber')
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
                </div>
              </template>
            </@tabsContent.kw>
            <input type="hidden" id="phoneActivated" name="phoneActivated" x-model="phoneActivated">
          </#if>
        </@tabsContentGroup.kw>
      </div>

      <@buttonGroup.kw>
        <@button.kw color="primary" type="submit">
          ${msg("doSubmit")}
        </@button.kw>
      </@buttonGroup.kw>
    </@form.kw>
  <#--  INFO SECTION  -->
  <#elseif section="info">
    <#if realm.duplicateEmailsAllowed>
      ${msg("emailInstructionUsername")}
    <#else>
      ${msg("emailInstruction")}
    </#if>

    <#if supportPhone??>
      ${msg("phoneInstruction")}
    </#if>
  <#--  NAV SECTION  -->
  <#elseif section="nav">
    <@link.kw color="secondary" href=url.loginUrl size="small">
      ${kcSanitize(msg("backToLogin"))?no_esc}
    </@link.kw>
  </#if>
</@layout.registrationLayout>
