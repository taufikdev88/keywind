<#macro kw name selected click_prevent="" rest...>
  <li
    class="w-full"
    role="presentation">

    <button
      class="w-full inline-block rounded-t-lg border-b-2 border-transparent p-4 hover:border-gray-300 hover:text-gray-600 dark:hover:text-gray-300"
      id="${name}-tab"
      data-tabs-target="#${name}-target"
      type="button"
      role="tab"
      aria-controls="${name}-target"
      x-bind:aria-selected="${selected}"
      <#if click_prevent?has_content> @click.prevent="${click_prevent}"</#if>

      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>>

      <#nested>
    </button>
  </li>
</#macro>
