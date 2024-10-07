<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/checkbox.ftl" as checkbox>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>

<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("password", "password-confirm"); section>

  <#--  SECTION HEADER  -->
  <#if section="header">
    ${msg("updatePasswordTitle")}
  <#--  FORM SECTION  -->
  <#elseif section="form">
    <@form.kw action=url.loginAction method="post">
      <#--  hidden forms  -->
      <input autocomplete="username" name="username" type="hidden" value="${username}">
      <input autocomplete="current-password" name="password" type="hidden">
      <#--  new password  -->
      <@input.kw
        autocomplete="new-password"
        autofocus=true
        invalid=messagesPerField.existsError("password", "password-confirm")
        label=msg("passwordNew")
        name="password-new"
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
      <#if isAppInitiatedAction??>
        <#--  logout other sessions checkbox  -->
        <@checkbox.kw
          checked=true
          label=msg("logoutOtherSessions")
          name="logout-sessions"
          value="on"
        />
      </#if>
      <#--  button submit and cancel  -->
      <@buttonGroup.kw>
        <#if isAppInitiatedAction??>
          <@button.kw color="primary" type="submit">
            ${msg("doSubmit")}
          </@button.kw>
          <@button.kw color="secondary" name="cancel-aia" type="submit" value="true">
            ${msg("doCancel")}
          </@button.kw>
        <#else>
          <@button.kw color="primary" type="submit">
            ${msg("doSubmit")}
          </@button.kw>
        </#if>
      </@buttonGroup.kw>
    </@form.kw>
  </#if>
</@layout.registrationLayout>
