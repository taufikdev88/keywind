<#import "/assets/icons/eye.ftl" as iconEye>
<#import "/assets/icons/eye-slash.ftl" as iconEyeSlash>

<#macro
  kw
  autofocus=false
  class="block border-secondary-200 mt-1 rounded-md w-full focus:border-primary-300 focus:ring focus:ring-primary-200 focus:ring-opacity-50 sm:text-sm"
  disabled=false
  disabled_function=""
  invalid=false
  placeholder=""
  label=""
  message=""
  name=""
  required=true
  type="text"
  model=""
  click=""
  readonly=false
  rest...
>
  <#if placeholder?has_content>
    <#assign ph = placeholder>
  <#else>
    <#assign ph = label>
  </#if>

  <div>
    <label class="sr-only" for="${name}">
      ${label}
    </label>
    <#if type == "password">
      <div class="relative" x-data="{ show: false }">
        <input
          <#if autofocus>autofocus</#if>
          <#if required>required</#if>
          <#if disabled_function?has_content>
            x-bind:disabled='${disabled_function}'
          <#elseif disabled>
            disabled
          </#if>

          aria-invalid="${invalid?c}"
          class="${class}"
          id="${name}"
          name="${name}"
          placeholder="${ph}"
          :type="show ? 'text' : 'password'"

          <#list rest as attrName, attrValue>
            ${attrName}="${attrValue}"
          </#list>
        >
        <button
          @click="show = !show"
          aria-controls="${name}"
          :aria-expanded="show"
          class="absolute text-secondary-400 right-3 top-3 sm:top-2"
          type="button"
        >
          <div x-show="!show">
            <@iconEye.kw />
          </div>
          <div x-cloak x-show="show">
            <@iconEyeSlash.kw />
          </div>
        </button>
      </div>
    <#else>
      <input
        <#if autofocus>autofocus</#if>
        <#if required>required</#if>
        <#if model?has_content>x-model="${model}"</#if>
        <#if click?has_content>x-on:click="${click}"</#if>
        <#if disabled_function?has_content>
          x-bind:disabled='${disabled_function}'
          x-bind:class="${disabled_function} ? 'cursor-not-allowed opacity-50' : ''"
        <#elseif disabled>
          disabled
        </#if>
        <#if readonly>readonly</#if>

        aria-invalid="${invalid?c}"
        class="${class}"
        id="${name}"
        name="${name}"
        placeholder="${ph}"
        type="${type}"

        <#list rest as attrName, attrValue>
          ${attrName}="${attrValue}"
        </#list>
      >
    </#if>
    <#if invalid?? && message??>
      <div class="mt-2 text-red-600 text-sm">
        ${message?no_esc}
      </div>
    </#if>
  </div>
</#macro>
