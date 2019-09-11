<?xml version="1.0"?>
<globals>
    <global id="hasNoActionBar" type="boolean" value="false" />
    <global id="parentActivityClass" value="" />
    <global id="excludeMenu" type="boolean" value="true" />
    <global id="isLauncher" type="boolean" value="false" />
    <global id="generateActivityTitle" type="boolean" value="false" />
    <global id="relativePackage" value="${ativityPackageName}" />
    <global id="activityClass" value="${pageName}Activity" />
    <#include "../common/common_globals.xml.ftl" />
</globals>

<#macro fileHeader>
/**
 * ================================================
 * Description:
 * <p>
 * Created by MVVMArmsTemplate on ${.now?string["MM/dd/yyyy HH:mm"]}
 * <a href="mailto:yudu233@gmail.com">Contact me</a>
 * <a href="https://github.com/yudu233">Follow me</a>
 * <a href="http://blog.yudu233.com">See me</a>
 * <a href="https://github.com/yudu233/MVVMArmsTemplate">模版请保持更新</a>
 * ================================================
 */
</#macro>
