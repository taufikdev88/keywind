<#import "template.ftl" as layout>
<#import "components/atoms/alert.ftl" as alert>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>

<@layout.registrationLayout; section>
  <#if section = "header">
    ${msg("deleteAccountConfirm")}
  <#elseif section = "form">
    <@form.kw action=url.loginAction method="post">
      <@alert.kw color="warning">
        ${msg("irreversibleAction")}
      </@alert.kw>

      <p>${msg("deletingImplies")}</p>

      <ul style="color: #72767b;list-style: disc;list-style-position: inside;">
        <li>${msg("loggingOutImmediately")}</li>
        <li>${msg("errasingData")}</li>
      </ul>

      <p class="delete-account-text">${msg("finalDeletionConfirmation")}</p>

      <@buttonGroup.kw>
        <@button.kw color="danger" type="submit">
          ${msg("doConfirmDelete")}
        </@button.kw>
        <#if triggered_from_aia>
          <@button.kw color="secondary" type="submit" name="cancel-aia" value="true">
            ${msg("doCancel")}
          </@button.kw>
        </#if>
      </@buttonGroup.kw>
    </@form.kw>
  </#if>
</@layout.registrationLayout>
