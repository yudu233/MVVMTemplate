package ${ativityPackageName}

import org.kodein.di.Kodein
import org.kodein.di.generic.instance
import google.architecture.common.base.view.BaseInjectActivity


<#import "root://activities/MVVMTemplate/globals.xml.ftl" as gb>

<@gb.fileHeader />

class ${pageName}Activity :BaseInjectActivity<Activity${pageName}Binding>(){

	private val viewModel: ${pageName}ViewModel by instance()

    override fun activityModule() = Kodein.Module("${pageName}ActivityModule") {
        import(${classToResource(pageName)}KodeinModule)
    }

    override val layoutId: Int
        get() = R.layout.${activityLayoutName}

    override fun initView(){
    	
    }

}