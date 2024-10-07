<#macro kw name hidden=true>
  <#if hidden!false>
    <#assign hiddenClass="hidden">
  <#else>
    <#assign hiddenClass="">
  </#if>

  <div
    class="${hiddenClass} rounded-lg bg-gray-50 dark:bg-gray-800"
    id="${name}-target"
    role="tabpanel"
    aria-labelledby="${name}-tab">

    <#nested>
  </div>
</#macro>
