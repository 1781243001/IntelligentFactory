
$(function(){
	/*setTimeout(function(){
		$("body").css({"display":"block"})
	},1600)*/
	
	var baseObj = new Base();
	var domainStr = baseObj.mainDomain;
	
	
	$(".cyd_navBox li").on("click",function(){
		$(this).addClass("cyd_active").siblings().removeClass("cyd_active")
	})
	
	var jzParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "e9356e20-c203-496f-b637-3eed075349fa|9e7f8445-9094-4640-adc9-4a5cda4b6876",
        RequestParams: [{ "value": "0", "key": "value1" }]
   	}

	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(jzParam),
	   	success: function(msg){
	   		console.log(JSON.parse(msg))
	   		
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)
			
		}
	});
	
	
	var gwParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "e9356e20-c203-496f-b637-3eed075349fa|c732de3a-0c23-4533-904a-e5e1910a9d57",
        //RequestParams: [{"value":"?","key":"AreaId"},{"value":"1910000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-18","key":"DateTime"}]
 	}
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(gwParam),
	   	success: function(msg){
	   		console.log(JSON.parse(msg))
	   		
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)
			
		}
	});
	
	
	
	var mxParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "e9356e20-c203-496f-b637-3eed075349fa|e845d54f-1676-49dc-aace-cd165008f320",
        RequestParams: [{"value":"1908","key":"AreaId"},{"value":"1921000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-18","key":"DateTime"}]
   	}

	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(mxParam),
	   	success: function(msg){
	   		console.log(JSON.parse(msg))
	   		var listData = JSON.parse(msg).PipeNetNodeDataList;
	   		var listDome = "";
	   		$.each(listData, function(i) {
	   			listDome += '<li class="cyd_innerConent clear">'+
								'<p>'+listData[i].EnergyNodeName+'</p>'+
								'<p>'+listData[i].InstrVal+'/'+listData[i].ConVal+'</p>'+
								'<p>'+listData[i].FstBalVal+'/'+listData[i].SecBalVal+'</p>'+
								'<p>'+listData[i].DifferenceData+'</p>'+
							'</li>';
	   		});
   			$(".cycontenty").append(listDome)
   			
   			/*function choose(){
   				$.each(listData, function(i) {
		   			
		   		});
   			}*/
   			
   			
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)
			
		}
	});
	
})
