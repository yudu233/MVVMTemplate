<?xml version="1.0"?>
<#import "root://activities/common/kotlin_macros.ftl" as kt>
<recipe>
<@kt.addAllKotlinDependencies />
<#if needActivity>
    <merge from="root/AndroidManifest.xml.ftl"
           to="${escapeXmlAttribute(manifestOut)}/debug/AndroidManifest.xml" />
</#if>

<#if needActivity>
    <merge from="root/AndroidManifest.xml.ftl"
           to="${escapeXmlAttribute(manifestOut)}/release/AndroidManifest.xml" />
</#if>


<#if needActivity && generateActivityLayout>
    <instantiate from="root/res/layout/activity.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml" />
</#if>

<#if needFragment && generateFragmentLayout>
    <instantiate from="root/res/layout/activity.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${fragmentLayoutName}.xml" />
</#if>


<#if needActivity>
    <instantiate from="root/src/app_package/BasicActivity.${ktOrJavaExt}.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.${ktOrJavaExt}" />
    <open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.kt" />
</#if>

<#if needFragment>
    <instantiate from="root/src/app_package/BaseInjectFragment.${ktOrJavaExt}.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(fragmentPackageName)}/${pageName}Fragment.${ktOrJavaExt}" />
    <open file="${projectOut}/src/main/java/${slashedPackageName(fragmentPackageName)}/${pageName}Fragment..kt" />
</#if>

<#if needViewModel>
    <instantiate from="root/src/app_package/BasicActivityViewModel.${ktOrJavaExt}.ftl"
        to="${projectOut}/src/main/java/${slashedPackageName(VideModelPackageName)}/${pageName}ViewModel.${ktOrJavaExt}" />
</#if>


<#if needKodeinModule>
    <instantiate from="root/src/app_package/BasicActivityKodeinModule.${ktOrJavaExt}.ftl"
        to="${projectOut}/src/main/java/${slashedPackageName(ModulePackageName)}/${pageName}KodeinModule.${ktOrJavaExt}" />

</#if>

<#if needDataSourceRepository>
    <instantiate from="root/src/app_package/BasicRepository.${ktOrJavaExt}.ftl"
        to="${projectOut}/src/main/java/${slashedPackageName(DataSourcePackageName)}/${pageName}Repository.${ktOrJavaExt}" />
        
</#if>

</recipe>
