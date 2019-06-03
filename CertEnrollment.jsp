var cerEnrollment_control = new cerEnrollment();
function checkIsIE(){
	var userAgent = navigator.userAgent, 
	rMsie = http://gz.cmbc.com.cn/(msie\s|trident.*rv:)([\w.]+)/;
	var ua = userAgent.toLowerCase();
	var match = rMsie.exec(ua);
	if (match != null) {
	    return true;
	}else{
	    return false;
	}
}
function cerEnrollment() {
};

/*******************************************************************************
* 函数名称：  init	
* 功能描述：	控件初始化
* 输入参数：  无
* 输出参数：	无
* 返 回 值：	           
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.init = function() {
    var eDiv = document.createElement("div");
    if (checkIsIE()) {
      if (window.navigator.cpuClass == "x86") {
          eDiv.innerHTML = "<object id=\"cerEnrollmentCtrl\" codebase=\"CMBCIE32.cab\" classid=\"clsid:C56059D0-C3B4-44B0-A6FD-5F7CF286873D\" width=0 height=0></object>";
       }
      else {
          eDiv.innerHTML = "<object id=\"cerEnrollmentCtrl\" codebase=\"CMBCIE64.cab\" classid=\"clsid:285D3EAA-82C4-455C-A10E-2164F2A5EBA9\" width=0 height=0></object>";
        }
      }
    else {
        eDiv.innerHTML = "<embed id=\"cerEnrollmentCtrl\" type=\"application/npCryptoKit.CMBC.x86\" style=\"height: 0px; width: 0px\">";
    }	
 	   document.body.appendChild(eDiv);
 }

 /*******************************************************************************
 * 函数名称： checkIsInstalled	
 * 功能描述：	检测控件是否安装。
 * 输入参数： 无
 * 输出参数：	无
 * 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果(控件安装：true/未安装：false)      
 * 其它说明：  
 * 修改日期		修改人	      修改内容       电子邮箱
 * ------------------------------------------------------------------------------
 * 2012-12-21	    姜景竹	      创建           jzjiang@cfca.com.cn
 *******************************************************************************/
 cerEnrollment.prototype.checkIsInstalled = function () {
     var cryptokitCtrl_OCX = document.getElementById("cerEnrollmentCtrl");
     if (!cryptokitCtrl_OCX) {
         cerEnrollment.prototype.init();
     }
     var obj = new Object();
     try {
         var retVal = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc();
         if (!retVal) {
             throw "";
         }
         obj.result = 0;
         obj.val = true;
     }
     catch (e) {
         obj.result = 1;
         obj.val = false;
     }
     return obj;
 }
 /*******************************************************************************
 * 函数名称： getVersion	
 * 功能描述：	获取控件版本号。
 * 输入参数： 无
 * 输出参数：	无
 * 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果(返回控件版本号)      
 * 其它说明：  
 * 修改日期		修改人	      修改内容       电子邮箱
 * ------------------------------------------------------------------------------
 * 2012-12-21	    姜景竹	      创建           jzjiang@cfca.com.cn
 *******************************************************************************/
 cerEnrollment.prototype.getVersion = function () {
     var cryptokitCtrl_OCX = document.getElementById("cerEnrollmentCtrl");
     if (!cryptokitCtrl_OCX) {
         cerEnrollment.prototype.init();
     }
     var obj = new Object();
     try {
         var version = document.getElementById("cerEnrollmentCtrl").CFCA_GetVersion();
         if (!version) {
             throw "";
         }
         obj.result = 0;
         obj.val = version;
     }
     catch (e) {
         obj.result = 1;
         obj.val = "未知版本";
     }
     return obj;
 }

/*******************************************************************************
* 函数名称：  verifyGenerateKeyPairPermission	
* 功能描述：	检验是否ActiveX控件是否有权限来生成密钥对。以此来决定是否IE是否要重启
* 输入参数：  无
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果      
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.verifyGenerateKeyPairPermission=function(){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
  
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	try {
	    var result = document.getElementById("cerEnrollmentCtrl").CFCA_HavePermissiontoGenerateKeyPair();
	    if (!result) {
	        throw "";
	    }
	    obj.result = 0;
	    obj.val = "您有权限生成密钥对";
   }
   catch(e){
   	   obj.result=1;
       var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc();    
       obj.val=LastErrorDesc;            
   }
   return obj;
}

/*******************************************************************************
* 函数名称：  verifyCertificateIntegrity	
* 功能描述：	检查CFCA证书链是否完整。解析XML文件，从XML文件中读取要检查的证书。检查根证书与二级证书是否在当前系统的Store中
* 输入参数：  无
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果             
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.verifyCertificateIntegrity=function(){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	try {   
      var result =document.getElementById("cerEnrollmentCtrl").CFCA_CheckCertificateChain();
      if (!result) {
          throw "";
      }
	  obj.result = 0;
	  obj.val = "证书链完整";
   }
   catch(e){
   	   obj.result=1;
       var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc();  
       obj.val=LastErrorDesc;              
   }
   return obj;
}


/*******************************************************************************
* 函数名称：  cFCA_GetCSPInfo	
* 功能描述：	返回系统中所有CSP的名称,系统中所有CSP的名称，若存在多个CSP，则以“||”线分割
* 输入参数：  无
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.cFCA_GetCSPInfo=function(){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	try {   
      var result =document.getElementById("cerEnrollmentCtrl").CFCA_GetCSPInfo();
      if (!result) {
          throw "";
      }
      obj.result = 0;
	  obj.val=result;       
   }
   catch(e){
   	   obj.result=1;
	     var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc(); 
	     obj.val=LastErrorDesc;               
   }
   return obj;
}



/*******************************************************************************
* 函数名称：  cFCA_SetCSPInfo	
* 功能描述：	设定CSP的名称及密钥长度信息。
* 输入参数：  lKeyLength    密钥长度。
              bstrCSPName   CSP的名称。
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.cFCA_SetCSPInfo=function(lKeyLength,bstrCSPName){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	try {   
      var result =document.getElementById("cerEnrollmentCtrl").CFCA_SetCSPInfo(lKeyLength,bstrCSPName);
      if (!result) {
          throw "";
      }
      obj.result = 0;
	  obj.val="成功";       
   }
   catch(e){
   	   obj.result=1;
	     var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc(); 
	     obj.val=LastErrorDesc;               
   }
   return obj;
}

/*******************************************************************************
* 函数名称：  cFCA_SetKeyAlgorithm	
* 功能描述：	申请单证时：设定密钥对生成算法（SM2/RSA）。
              申请签名证书时：设定证书签名算法（SM2/RSA）。
              申请双证时：设定密钥对生成算法及证书签名算法（SM2/RSA）。
* 输入参数：  bstrKeyAlgorithm    密钥对生成算法标识字符串 取值为：字符串SM2/RSA，不区分大小写。
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.cFCA_SetKeyAlgorithm=function(bstrKeyAlgorithm){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	try {   
      var result =document.getElementById("cerEnrollmentCtrl").CFCA_SetKeyAlgorithm(bstrKeyAlgorithm);
      if (!result) {
          throw "";
      }
      obj.result = 0;
	  obj.val="成功";       
   }
   catch(e){
   	   obj.result=1;
	     var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc(); 
	     obj.val=LastErrorDesc;               
   }
   return obj;
}


/*******************************************************************************
* 函数名称：  cFCA_PKCS10CertRequisition	
* 功能描述：	生成证书申请消息（符合PKCS#10标准），用于申请签名证书或双证。
* 输入参数：  bstrSubjectDN：证书的Subject DN。
              lCertType：取值为 1：表示签名单证；2：表示双证。
              lSignPrivateKeyGenerateFlags：签名证书私钥生成标志。取值：
                                            0x0 表示生成的签名私钥不可导出，对其进行操作时不进行询问；
                                            0x1 表示生成的签名私钥可导出；
                                            0x2 表示对签名私钥进行操作时进行询问；
                                            0x8000 表示对签名私钥进行密码保护，该标志不支持Windows Server 2003
                                                   Windows XP及 Windows 2000；
                                            以上取值可通过‘或’关系进行组合设置。

* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果(PKCS#10请求（Base64编码))         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.cFCA_PKCS10CertRequisition=function(bstrSubjectDN,lCertType,lSignPrivateKeyGenerateFlags){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	try {   
      var result =document.getElementById("cerEnrollmentCtrl").CFCA_PKCS10CertRequisition(bstrSubjectDN,lCertType,lSignPrivateKeyGenerateFlags);
      if (!result) {
          throw "";
      }
      obj.result = 0;
	  obj.val=result;       
   }
   catch(e){
   	   obj.result=1;
	     var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc(); 
	     obj.val=LastErrorDesc;               
   }
   return obj;
}


/*******************************************************************************
* 函数名称：  cFCA_GetContainer	
* 功能描述：	取得当前密钥对的密钥容器名称。
* 输入参数：  无
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.cFCA_GetContainer=function(){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	try {   
      var result =document.getElementById("cerEnrollmentCtrl").CFCA_GetContainer();
      if (!result) {
          throw "";
      }
      obj.result = 0;
	  obj.val=result;       
   }
   catch(e){
   	   obj.result=1;
	     var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc(); 
	     obj.val=LastErrorDesc;               
   }
   return obj;
}

/*******************************************************************************
* 函数名称：  pKCS10Requisition_SignCert
* 功能描述：	Pkcs10单证申请
* 输入参数：  lKeyLength    密钥长度。
              bstrCSPName   CSP的名称。
              bstrKeyAlgorithm    密钥对生成算法标识字符串 取值为：字符串SM2/RSA，不区分大小写。
              bstrSubjectDN：证书的Subject DN。
              lCertType：取值为 1：表示签名单证；2：表示双证。
              lSignPrivateKeyGenerateFlags：签名证书私钥生成标志。取值：
                                            0x0 表示生成的签名私钥不可导出，对其进行操作时不进行询问；
                                            0x1 表示生成的签名私钥可导出；
                                            0x2 表示对签名私钥进行操作时进行询问；
                                            0x8000 表示对签名私钥进行密码保护，该标志不支持Windows Server 2003
                                                   Windows XP及 Windows 2000；
                                            以上取值可通过‘或’关系进行组合设置。

* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二certval生成证书内容(PKCS#10请求（Base64编码)),属性三containerval 容器名称         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.pKCS10Requisition_SignCert=function(keyLength,cspName,keyAlgorithm,strSubjectDN,lCertType,lSignPrivateKeyGenerateFlags){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	
 var res1 =this.cFCA_SetCSPInfo(keyLength, cspName);
 if(res1.result==0){
 	  var res2= this.cFCA_SetKeyAlgorithm(keyAlgorithm);
 	   if(res2.result==0){
 	   	 	var pkcs10Requisition = this.cFCA_PKCS10CertRequisition(strSubjectDN, lCertType, lSignPrivateKeyGenerateFlags);
 	   	 	 if(pkcs10Requisition.result==0){
 	   	 	 	 var contianerName = this.cFCA_GetContainer();
 	   	 	 	 if(contianerName.result==0){
 	   	 	 	 	obj.result=0;
 	   	 	 	 	obj.certval=pkcs10Requisition.val;
 	   	 	 	 	obj.containerval=contianerName.val;
 	   	 	 	 }
 	   	 	 	 else
 	   	 	 	 {
 	   	 	 	 	obj.result=1;                         //取得当前密钥对的密钥容器名称失败
 	   	 	 	 	obj.certval=contianerName.val;
 	   	 	 	 	obj.containerval="";
 	   	 	 	 }	   	 	 	 
 	   	   }
 	   	   else
 	   	   {
 	   	   		obj.result=2;                         //生成PKCS10证书失败
 	   	 	 	 	obj.certval=pkcs10Requisition.val;  	
 	   	 	 	 	obj.containerval="";
 	   	   }
 	   }
 	   else{
 	   	   	obj.result=3;                           //设置算法失败
 	   	 	 	obj.certval=res2.val;  	
 	   	 	 	obj.containerval="";
 	   }
 	
 	}
 	else{
 		     	obj.result=4;                           //设定CSP的名称及密钥长度信息失败
 	   	 	 	obj.certval=res1.val;  	
 	   	 	 	obj.containerval="";
 	}	
  return obj;
}


/*******************************************************************************
* 函数名称：  cFCA_GetTempPublickey	
* 功能描述：	取得CSP生成的临时密钥对的公钥，用于申请加密单证证书。
* 输入参数：  无
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、返回临时公钥（Base64编码）         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.cFCA_GetTempPublickey=function(){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	try {   
      var result =document.getElementById("cerEnrollmentCtrl").CFCA_GetTempPublickey();
      if (!result) {
          throw "";
      }
      obj.result = 0;
	  obj.val=result;       
   }
   catch(e){
   	   obj.result=1;
	     var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc(); 
	     obj.val=LastErrorDesc;               
   }
   return obj;
}


/*******************************************************************************
* 函数名称：  getTempPublickey
* 功能描述：	Pkcs10单证申请
* 输入参数：  lKeyLength    密钥长度。
              bstrCSPName   CSP的名称。
              bstrKeyAlgorithm    密钥对生成算法标识字符串 取值为：字符串SM2/RSA，不区分大小写。
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二tempval临时公钥(PKCS#10请求（Base64编码)),属性三containerval 容器名称         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.getTempPublickey=function(keyLength,cspName,keyAlgorithm){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
 var obj=new Object();
 var res1 =this.cFCA_SetCSPInfo(keyLength, cspName);
 if(res1.result==0){
 	  var res2= this.cFCA_SetKeyAlgorithm(keyAlgorithm);
 	   if(res2.result==0){
 	   	 	var tmpPublicKey = this.cFCA_GetTempPublickey();
 	   	 	 if(tmpPublicKey.result==0){
 	   	 	 	 var contianerName = this.cFCA_GetContainer();
 	   	 	 	 if(contianerName.result==0){
 	   	 	 	 	obj.result=0;
 	   	 	 	 	obj.tempval=tmpPublicKey.val;
 	   	 	 	 	obj.containerval=contianerName.val;
 	   	 	 	 }
 	   	 	 	 else
 	   	 	 	 {
 	   	 	 	 	obj.result=1;                         //取得当前密钥对的密钥容器名称失败
 	   	 	 	 	obj.tempval=contianerName.val;
 	   	 	 	 	obj.containerval="";
 	   	 	 	 }	   	 	 	 
 	   	   }
 	   	   else
 	   	   {
 	   	   		obj.result=2;                         //生成临时公钥失败
 	   	 	 	 	obj.tempval=pkcs10Requisition.val;  	
 	   	 	 	 	obj.containerval="";
 	   	   }
 	   }
 	   else{
 	   	   	obj.result=3;                           //设置算法失败
 	   	 	 	obj.tempval=res2.val;  	
 	   	 	 	obj.containerval="";
 	   }
 	
 	}
 	else{
 		     	obj.result=4;                           //设定CSP的名称及密钥长度信息失败
 	   	 	 	obj.tempval=res1.val;  	
 	   	 	 	obj.containerval="";
 	}	
  return obj;
}


/*******************************************************************************
* 函数名称：  cFCA_ImportSignCert	
* 功能描述：	导入签名证书到指定的CSP中
* 输入参数：  lCertType:取值为 1：表示签名单证；2：表示双证。
              bstrSignCert：签名证书信息。
              bstrContainerName：密钥容器名称。
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.cFCA_ImportSignCert=function(lCertType,bstrSignCert,bstrContainerName){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	try {   
      var result =document.getElementById("cerEnrollmentCtrl").CFCA_ImportSignCert(lCertType,bstrSignCert,bstrContainerName);
      if (!result) {
          throw "";
      }
      obj.result = 0;
	  obj.val="成功";       
   }
   catch(e){
   	   obj.result=1;
	     var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc(); 
	     obj.val=LastErrorDesc;               
   }
   return obj;
}

/*******************************************************************************
* 函数名称：  installRSASignCert
* 功能描述：	安装签名证书
* 输入参数：  lKeyLength    密钥长度。
              bstrCSPName   CSP的名称。
              contianerName 容器名称
              bstrKeyAlgorithm    密钥对生成算法标识字符串 取值为：字符串SM2/RSA，不区分大小写。
              lCertType:取值为 1：表示签名单证；2：表示双证。
              bstrSignCert：签名证书信息。
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val,执行结果
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.installRSASignCert=function(keyLength,cspName,contianerName,keyAlgorithm,lCertType,bstrSignCert){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
 var obj=new Object();
 var res1 =this.cFCA_SetCSPInfo(keyLength, cspName);
 if(res1.result==0){
 	  var res2= this.cFCA_SetKeyAlgorithm(keyAlgorithm);
 	   if(res2.result==0){
 	   	 	 	 var importcert = this.cFCA_ImportSignCert(lCertType,bstrSignCert,contianerName);
 	   	 	 	 if(importcert.result==0){
 	   	 	 	 	obj.result=0;
 	   	 	 	 	obj.val="导入成功";
 	   	 	 	 }
 	   	 	 	 else
 	   	 	 	 {
 	   	 	 	 	obj.result=1;                         //导入证书失败
 	   	 	  	obj.val=importcert.val;
 	   	 	 	 }	   	 	 	 
 	   }
 	   else{
 	   	   	obj.result=3;                           //设置算法失败
 	   	 	 	obj.val=res2.val;  	
 	   }
 	
 	}
 	else{
 		     	obj.result=4;                           //设定CSP的名称及密钥长度信息失败
 	   	 	 	obj.val=res1.val;  	
 	}	
  return obj;
}

/*******************************************************************************
* 函数名称：  getLastErrorDesc	
* 功能描述：	显示最近一次调用接口导致发生错误的描述信息
* 输入参数：  无
* 输出参数：	无
* 返 回 值：	字符串，代表最后一次出错信息，如果为空则表示没有错误         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.getLastErrorDesc=function(){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}	 
    return document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc();
}


/*******************************************************************************
* 函数名称：  cFCA_GetAllCertInfo	
* 功能描述：	返回系统中所有证书的信息。包括证书主题、序列号、证书生效时间、证书截止时间、提供证书的CSP Name
* 输入参数：  无
* 输出参数：	无
* 返 回 值：	返回系统中所有证书信息，若存在多个证书，则以“||”线分割。证书内部属性用“；”隔开       
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.cFCA_GetAllCertInfo=function(){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}	 
	var obj=new Object();
	try {   
      var result =document.getElementById("cerEnrollmentCtrl").CFCA_GetAllCertInfo();
      if (!result) {
          throw "";
      }
      obj.result = 0;
	  obj.val=result;       
   }
   catch(e){
   	   obj.result=1;
	     var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc(); 
	     obj.val=LastErrorDesc;               
   }
   return obj;
}


/*******************************************************************************
* 函数名称：  cFCA_ImportEncryptCert	
* 功能描述：	安装加密证书到指定的CSP中
* 输入参数：  bstrEncryptedPrivateKey：类似于数字信封，其中含有证书相对应的私钥（私钥+对称密钥，非标准Base64编码，中间含有逗号）。
                                            CA颁发的私钥需用对称密钥来解密，且该对称密钥已经用之前申请时上传的临时公钥加密过。
              bstrP7Cert：公钥证书（Base64编码）。
              bstrContainerName：密钥容器名称。
              lEncryptCertPrivateKeyFlags：加密证书私钥安装标志。取值：
                                0x0 表示加密证书私钥将不可导出，且对其进行操作时不进行询问；
                                0x1 表示加密证书私钥可导出；
                                0x2 表示对加密证书私钥进行操作时将进行询问 
                                    以上取值可通过‘或’关系进行组合设置
* 输出参数：	无
* 返 回 值：	对象obj,属性一result,方法执行结果代码，0代表称成功，其他代表失败，属性二val、执行结果         
* 其它说明：  
* 修改日期		修改人	      修改内容       电子邮箱
* ------------------------------------------------------------------------------
* 2011-04-11	许华锋	      创建           xuhuafeng@bris.cn
*******************************************************************************/
cerEnrollment.prototype.cFCA_ImportEncryptCert=function(lCertType,bstrSignCert,bstrContainerName){
  var cerEnrollment_OCX = document.getElementById("cerEnrollmentCtrl");
	if (!cerEnrollment_OCX) {
		cerEnrollment.prototype.init();
	}
	var obj=new Object();
	try {   
      var result =document.getElementById("cerEnrollmentCtrl").CFCA_ImportEncryptCert(lCertType,bstrSignCert,bstrContainerName);
      if (!result) {
          throw "";
      }
      obj.result = 0;
	  obj.val="成功";       
   }
   catch(e){
   	   obj.result=1;
	     var LastErrorDesc = document.getElementById("cerEnrollmentCtrl").GetLastErrorDesc(); 
	     obj.val=LastErrorDesc;               
   }
   return obj;
}






