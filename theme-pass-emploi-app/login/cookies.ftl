<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        ${msg("cookieNotFoundMessage")}
    <#elseif section = "form">
        <div id="kc-error-message">
            <p class="instruction">${message.summary?no_esc}</p>
            <#if client?? && client.baseUrl?has_content>
                <p>${msg("cookieNotFoundSafariHelp")}</p>
                <p>${msg("cookieNotFoundAndroidHelp")}</p>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>