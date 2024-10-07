<#macro kw>
  <#compress>
    <#if !realm.loginWithEmailAllowed>
      <#if loginWithPhoneNumber??>
        ${msg("usernameOrPhoneNumber")}
      <#else>
        ${msg("username")}
      </#if>
    <#elseif !realm.registrationEmailAsUsername>
      <#if loginWithPhoneNumber??>
        ${msg("usernameOrEmailOrPhoneNumber")}
      <#else>
        ${msg("usernameOrEmail")}
      </#if>
    <#else>
      <#if loginWithPhoneNumber??>
        ${msg("emailOrPhoneNumber")}
      <#else>
        ${msg("email")}
      </#if>
    </#if>
  </#compress>
</#macro>
