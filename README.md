@[TOC](基于MVVM+Kodein编写的页面模板)

#### 前言

在项目中使用框架Arms时候，带有一键生成页面模板，很方面。最近在练习MVVM，于是尝试编写一套页面模板。

#### 概述

IDE 自带很多模板，可以看到内置了很多模板，减少了部分代码的编写，我们可以根据这些模板代码去学习如何定制页面模板
![IDE自带模板](https://img-blog.csdnimg.cn/2019091110360927.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbmF0XzMzNjgwOTU0,size_16,color_FFFFFF,t_70)

#### 模板结构文件分析

以==EmptyActivity==进行分析，模板放置路径为：==/plugins/android/lib/templates/activities==
![BasicActivity\](https://img-blog.csdnimg.cn/20190911104820353.png)](https://img-blog.csdnimg.cn/2019091111100774.png)
可以看到每一个模板都包含如图所示的文件
- root 资源文件、模板文件
	- src
		- app_package
			-  SimpleActivity.kt.ftl
	- res
		- layout	 
- globals.xml.ftl	主要用于提供参数
- recipe.xml.ftl		主要用于生成我们实际需要的代码，资源文件等
- template.xml		parameter标签，主要用于为图形界面提供参数
- template_balnk_activity.png	缩略图

#### 语法分析

##### 1.template.xml
我们可以看到主要代码如下

```
<?xml version="1.0"?>
<template
    format="5"
    revision="5"
    name="Empty Activity"   模板名称
    minApi="9"
    minBuildApi="14"
    description="Creates a new empty activity">

    <category value="Activity" />	模板类型
    <formfactor value="Mobile" />
    
	<parameter	参数变量
        id="activityClass"		变量名, 变量的唯一标识
        name="Activity Name"	在创建Activity时展示的变量名
        type="string"	类型
        constraints="class|unique|nonempty"		变量约束
        suggest="${layoutToActivity(layoutName)}"		 推荐值，未修改变量时根据其他变量生成
        default="MainActivity"		默认值
        help="The name of the activity class to create" />		当编辑一个变量时，显示在下方的提示

    <!-- 128x128 thumbnails relative to template.xml -->
    <thumbs>		缩略图
        <!-- default thumbnail is required -->
        <thumb>template_blank_activity.png</thumb>
    </thumbs>

    <globals file="globals.xml.ftl" />
    <execute file="recipe.xml.ftl" />

</template>
```
##### 2.globals.xml.flt
globals 存储的一些全局变量
```
<?xml version="1.0"?>
<globals>
    <global id="hasNoActionBar" type="boolean" value="false" />
    <global id="parentActivityClass" value="" />
    <global id="simpleLayoutName" value="${layoutName}" />
    <global id="excludeMenu" type="boolean" value="true" />
    <global id="generateActivityTitle" type="boolean" value="false" />
    <#include "../common/common_globals.xml.ftl" />
</globals>

```

##### 3.recipe.xml.ftl 
```
<?xml version="1.0"?>
<#import "root://activities/common/kotlin_macros.ftl" as kt>
<recipe>
    <#include "../common/recipe_manifest.xml.ftl" />
    <@kt.addAllKotlinDependencies />

<#if generateLayout>
    <#include "../common/recipe_simple.xml.ftl" />
    <open file="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
</#if>

    <instantiate from="root/src/app_package/SimpleActivity.${ktOrJavaExt}.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.${ktOrJavaExt}" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.${ktOrJavaExt}" />

</recipe>

```
recipe中主要使用以下五种指令：

- copy: 将from属性指定文件或一整个文件夹复制到to指定的位置。如果to属性不写，会采用from属性相同的路径并把文件名的.ftl后缀去掉（如果是ftl后缀的话）。
- instantiate：实例化，类似copy，但在复制前会对文件进行预处理，也就是计算文件里的插值和执行里面的指令。
- merge: 合并文件，一般用于string.xml, color.xml等资源文件和 AndroidManifest.xml
- open：完成所有复制工作后在Android Studio打开这些文件
- dependency：依赖库，会自动下载mavenUrl所指定的library。 

freemaker基本语法：
#### if指令
```
<#if needActivity>
...
<#/if>

<#if needActivity && needFragment>
...
</#if>

<#if needActivity>
...
<#elseif needFragment>
...
<#else>
...
</#if>
```
#### 编写自定义模板

#### 1.template.xml实例代码
```
<?xml version="1.0"?>
<template
    name="MVVM全家桶 "
    description="一键创建MVVM单个页面所需的全部组件，结合Kotlin + Kodein + Databinding + ViewModel"
    format="5"
    minApi="9"
    minBuildApi="15"
    revision="1">

    <category value="Activity" />
    <formfactor value="Mobile" />

    <parameter
        name="Page Name"
        constraints="unique|nonempty"
        default="Main"
        help="请填写页面名,如填写 Main,会自动生成 MainActivity, MainModule 等文件"
        id="pageName"
        type="string" />

    <parameter
        name="Root Package Name"
        constraints="package"
        default="com.mycompany.myapp"
        help="请填写你的项目包名,请认真核实此包名是否是正确的项目包名,不能包含子包,正确的格式如:com.rain.music"
        id="packageName"
        type="string" />


    <parameter
        name="Generate Activity"
        default="true"
        help="是否需要生成 Activity ? 不勾选则不生成"
        id="needActivity"
        type="boolean" />


    <parameter
        name="Activity Layout Name"
        constraints="layout|nonempty"
        default="activity_main"
        help="Activity 创建之前需要填写 Activity 的布局名,若布局已创建就直接填写此布局名,若还没创建此布局,请勾选下面的单选框"
        id="activityLayoutName"
        suggest="${activityToLayout(pageName)}"
        type="string"
        visibility="needActivity" />


    <parameter
        name="Generate Activity Layout"
        default="true"
        help="是否需要给 Activity 生成布局? 若勾选,则使用上面的布局名给此 Activity 创建默认的布局"
        id="generateActivityLayout"
        type="boolean"
        visibility="needActivity" />


    <parameter
        name="Ativity Package Name"
        constraints="package"
        help="Activity 将被输出到此包下,请认真核实此包名是否是你需要输出的目标包名"
        id="ativityPackageName"
        suggest="${packageName}.view.activity"
        type="string"
        visibility="needActivity" />


    <parameter
        name="Generate Fragment"
        default="false"
        help="是否需要生成 Fragment ? 不勾选则不生成"
        id="needFragment"
        type="boolean" />


    <parameter
        name="Fragment Layout Name"
        constraints="layout|nonempty"
        default="fragment_main"
        help="Fragment 创建之前需要填写 Fragment 的布局名,若布局已创建就直接填写此布局名,若还没创建此布局,请勾选下面的单选框"
        id="fragmentLayoutName"
        suggest="fragment_${classToResource(pageName)}"
        type="string"
        visibility="needFragment" />


    <parameter
        name="Generate Fragment Layout"
        default="true"
        help="是否需要给 Fragment 生成布局? 若勾选,则使用上面的布局名给此 Fragment 创建默认的布局"
        id="generateFragmentLayout"
        type="boolean"
        visibility="needFragment" />


    <parameter
        name="Fragment Package Name"
        constraints="package"
        help="Fragment 将被输出到此包下,请认真核实此包名是否是你需要输出的目标包名"
        id="fragmentPackageName"
        suggest="${packageName}.view.fragment"
        type="string"
        visibility="needFragment" />


	<parameter
        name = "Generate DataSourceRepository"
        default = "true"
        help = "是否需要生成 needDataSourceRepository ? 不勾选则不生成"
        id = "needDataSourceRepository"
        type = "boolean"/>

    <parameter
        name = "DataSourceRepository Package Name"
        constraints = "package"
        help= "DataSourceRepository 将被输出到此包下，请认真核实此包名是否是你需要输出的目标包名"
        id="DataSourcePackageName"
        suggest="${packageName}.data.source"
        type="string"
        visibility="needDataSourceRepository" />

    <parameter 
        name="DataSourceRepository class name" 
        constraints="nonempty|class|unique" 
        default="MyDataSourceRepository"
        id="dataSourceRepositoryName" 
        suggest="${extractLetters(pageName)}DataSourceRepository"
        type="string" 
        visibility="false" />

    <parameter
        name = "Generate RemoteDataSource"
        default = "true"
        help = "是否需要生成 RemoteDataSource ? 不勾选则不生成"
        id = "needRemoteDataSource"
        type = "boolean"/>

    <parameter 
        name="RemoteDataSource class name" 
        constraints="nonempty|class|unique" 
        default="MyRemoteDataSource"
        id="remoteDataSourceName" 
        suggest="${extractLetters(pageName)}RemoteDataSource"
        type="string"
        visibility="false" />

    <parameter
        name = "Generate LocalDataSource"
        default = "false"
        help = "是否需要生成 LocalDataSource ? 不勾选则不生成"
        id = "needLocalDataSource"
        type = "boolean"/>

    <parameter 
        name="LocalDataSource class name" 
        constraints="nonempty|class|unique" 
        default="MyLocalDataSource"
        id="localDataSourceName" 
        suggest="${extractLetters(pageName)}LocalDataSource"
        type="string" 
        visibility="false" />

    <parameter
        name="Generate ViewModel"
        default="true"
        help="是否需要生成 ViewModel ? 不勾选则不生成"
        id="needViewModel"
        type="boolean" />

    <parameter
        name="ViewModule Package Name"
        constraints="package"
        help="ViewModel 将被输出到此包下,请认真核实此包名是否是你需要输出的目标包名"
        id="VideModelPackageName"
        suggest="${packageName}.viewmodel"
        type="string"
        visibility="needViewModel" />


    <parameter
        name="Generate DI module of Kodein"
        default="true"
        help="是否需要生成 Kodein Module组件? 不勾选则不生成"
        id="needKodeinModule"
        type="boolean" />

    <parameter
        name="Module Package Name"
        constraints="package"
        help="DI Module 将被输出到此包下,请认真核实此包名是否是你需要输出的目标包名"
        id="ModulePackageName"
        suggest="${packageName}.di"
        type="string"
        visibility="needKodeinModule" />


    <!-- 128x128 thumbnails relative to template.xml -->
    <thumbs>
        <!-- default thumbnail is required -->
        <thumb>template_blank_activity.png</thumb>
    </thumbs>

    <globals file="globals.xml.ftl" />
    <execute file="recipe.xml.ftl" />

</template>

```
#### 2.页面效果图
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190911114150631.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbmF0XzMzNjgwOTU0,size_16,color_FFFFFF,t_70)

#### 3.最终生成文件效果图
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019091111534866.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbmF0XzMzNjgwOTU0,size_16,color_FFFFFF,t_70)

#### 4.Github 代码地址
模板代码已上传至Github:[MVVMTemplate](https://github.com/yudu233/MVVMTemplate)

有问题或者不足之处欢迎指出！  顺便点个赞吧~