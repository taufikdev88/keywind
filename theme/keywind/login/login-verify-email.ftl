<#import "template.ftl" as layout>

<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout
  displayInfo=true; section>
  <#if section = "header">
    ${msg("emailVerifyTitle")}
  <#elseif section = "form">
        <p class="instruction">${msg("emailVerifyInstruction1",user.email)}</p>
  <#elseif section = "info">
    <p class="instruction">
      ${msg("emailVerifyInstruction2")}
      <br/>
      <@link.kw href=url.loginAction>${msg("doClickHere")}</@link.kw> ${msg("emailVerifyInstruction3")}
    </p>
  </#if>

</@layout.registrationLayout>
