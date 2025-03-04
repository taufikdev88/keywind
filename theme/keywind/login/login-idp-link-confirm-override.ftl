<#import "template.ftl" as layout>

<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout; section>
  <#if section="header">
    ${msg("confirmOverrideIdpTitle")}
  <#elseif section="form">
    <@form.kw action=url.loginAction method="post">
      ${msg("pageExpiredMsg1")} <@link.kw href=url.loginRestartFlowUrl>${msg("doClickHere")}</@link.kw>
      <@button.kw color="primary" name="submitAction" type="submit" value="confirmOverride">
        ${msg("confirmOverrideIdpContinue", idpDisplayName)}
      </@button.kw>
    </@form.kw>
  </#if>
</@layout.registrationLayout>
