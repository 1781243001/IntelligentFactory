$(function(){
	/*setTimeout(function(){
		$("body").css({"display":"block"})
	},1600)*/
	var baseObj = new Base();
	var domainStr = baseObj.mainDomain;
	var loading = new Loading()
	
	
	//初始化给<label></label>标签赋值为当前时间
	var newDate = new Date()
	$("label").text(baseObj.formatNDate(newDate))
	
	//处理
	$(".select").change(function(){
		if($(".select").val() == ''){
			var date = new Date()
			$("label").text(baseObj.formatNDate(date))
		} else {
			$("label").text(baseObj.formatNDate($(".select").val()))
		}
	})
	
	
	
	
	$(".liang").on("click",function(event){
		event.stopPropagation()
		$(".chLayer").css({"display":"block"});
		$(".liangbox").css({"display":"block"});
		$(".jzchbox").css({"display":"none"});
	})
	$(".jzch").on("click",function(event){
		event.stopPropagation()
		$(".chLayer").css({"display":"block"});
		$(".jzchbox").css({"display":"block"});
		$(".liangbox").css({"display":"none"});
	})
	$(".chLayer").on("click",function(){
		$(this).css({"display":"none"})
	})
	 
	$(".jzchbox").on("click",function(event){
		event.stopPropagation()
	})
	
	
	$(".myshowcontent").on("click",function(){
		
		$(this).addClass("bk").siblings().removeClass("bk");
		$(".chLayer").css({"display":"none"});
		$(".liang").text($(this).text())
		console.log($(this).attr("data-type"))
		var dataType = $(this).attr("data-type");
		graphs(dataType)
		details(dataType)
		
	})
	var jArray = new Array("自产");
	var cArray = new Array("消耗")
	
	var strJson = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "696969f2-bc52-4fec-bf9f-9859d528a750|12425b7a-01e0-4c8c-9e1c-98de7e3b17e9",//"54e36de2-18c2-43f4-ae7c-28348c141059|41a36aa1-d997-4ab2-894c-7eefad6e7f91",
        RequestParams: [{ "value": "0", "key": "value1" }]
   	}	
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(strJson),
	   	success: function(msg){
	   		console.log(JSON.parse(msg))
	   		var jzListAll = JSON.parse(msg).mediumList[0].children;
	   		var jzListLeftDome = '<div data-areaId='+JSON.parse(msg).mediumList[0].id+' class="alone">'+
									'<p>'+JSON.parse(msg).mediumList[0].text+'</p>'+
								'</div>';
	   		$.each(jzListAll, function(i) {
	   			jzListLeftDome += 	'<div data-areaId='+jzListAll[i].id+' class="myshowcontentL">'+
										'<p>'+jzListAll[i].text+'</p>'+
									'</div>';
	   		});
	   		$(".boxleft").append(jzListLeftDome);
	   		
	   		
	   		$(".alone").on("click",function(){
	   			$(".boxright").empty();
	   			console.log($(this).attr("data-areaid"))
	   			var childrenD ='<div data-chidrenId='+$(this).attr("data-areaid")+' class="myshowcontentR ralone">'+
									'<p>全部</p>'+
								'</div>';
				$(".boxright").append(childrenD);
				console.log(childrenD)
				console.log($(".boxright").children())
				$(".ralone").click(function(){
					console.log($(this).attr("data-chidrenId"))
					$(this).addClass("bk").siblings().removeClass("bk");
					setTimeout(function(){
						$(".chLayer").css({"display":"none"})
					},600)
				})
	   		})
	   		
	   		
	   		
	   		$(".myshowcontentL").on("click",function(){
	   			$(".boxright").empty();
	   			$(this).find("p").addClass("text")
	   			$(this).siblings().find("p").removeClass("text");
	   			var thisAreaId = $(this).attr("data-areaId");
				$.each(jzListAll, function(i) {
					if(thisAreaId == jzListAll[i].id){
						var childrenAreaId = jzListAll[i].children;
						console.log(childrenAreaId)
						var childrenDome = "";
						if(childrenAreaId.length == 0){
							childrenDome ='<div data-chidrenId='+thisAreaId+' class="myshowcontentR">'+
												'<p>全部</p>'+
											'</div>'
						} else {
							$.each(childrenAreaId, function(j) {
								childrenDome += '<div data-chidrenId='+childrenAreaId[j].id+' class="myshowcontentR">'+
													'<p>'+childrenAreaId[j].text+'</p>'+
												'</div>';
							});
						}
						$(".boxright").append(childrenDome);
						$(".myshowcontentR").on("click",function(){
							$(this).addClass("bk").siblings().removeClass("bk");
							setTimeout(function(){
								$(".chLayer").css({"display":"none"})
							},600)
						})	
					}
				});
			})
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			//loading.hide();
            //loading.alertMsg('获取问题类型失败！');
		}
	});
	
	//KPI面板
	var KPIJson = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "696969f2-bc52-4fec-bf9f-9859d528a750|7134af06-0e2a-40a7-9b74-48751fa535ab",
        RequestParams: [{"value":"19003","key":"AreaId"},{"value":"1910000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-06","key":"DateTime"}]
    }
		
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(KPIJson),
	   	success: function(msg){
	   		console.log(JSON.parse(msg))
	   		var KIPData = JSON.parse(msg);
			var dataTpye = 0;
	   		
	   		for(key in KIPData){
	   			if(key == '2017/6/6'){
	   				var dateData = KIPData[key]
	   				$.each(dateData, function(i) {
			   			if(dataTpye == dateData[i].id){
			   				console.log(dateData[i].data)
			   				var KPIDataAll = dateData[i].data;
			   				console.log(KPIDataAll)
			   				/*var KPIDome =  	'<div class="tbox clear">'+
												'<div class="tbox_contentl clear">'+
													'<div class="tbox_top clear">'+
														'<p>购入总量:</p><p>(万千瓦时/万吨)</p>'+
													'</div>'+
													'<div class="tbox_bottom clear">'+
														'<div class="clear">'+
															'<p>昨日总量:</p><p>'+KPIDataAll.PurchaseTotal+'</p>'+
														'</div>'+
														'<div class="clear">'+
															'<p>本月累计:</p><p>'+KPIDataAll+'</p>'+
														'</div>'+
													'</div>'+
												'</div>'+
												'<div class="tbox_contentrone">'+
													'<div>'+KPIDataAll+'</div>'+
													'<div>'+
														'<span>环比:</span>'+
														'<span>'+KPIDataAll+'</span>'+
													'</div>'+
												'</div>'+
											'</div>'+
											'<div class="tbox clear">' +
												'<div class="tbox_contentl clear">'+
													'<div class="tbox_top clear">'+
														'<p>自产总量:</p><p>(万千瓦时/万吨)</p>'+
													'</div>'+
													'<div class="tbox_bottom clear">'+
														'<div class="clear">'+
															'<p>昨日总量:</p><p>'+KPIDataAll+'</p>'+
														'</div>'+
														'<div class="clear">'+
															'<p>本月累计:</p><p>'+KPIDataAll+'</p>'+
														'</div>'+
													'</div>'+
												'</div>'+
												'<div class="tbox_contentrtwo">'+
													'<div>'+KPIDataAll+'</div>'+
													'<div>'+
														'<span>环比:</span>'+
														'<span>'++'</span>'+
													'</div>'+
												'</div>'+
											'</div>'+
											'<div class="tbox clear">'+
												'<div class="tbox_contentl clear">'+
													'<div class="tbox_top clear">'+
														'<p>消耗总量:</p><p>(万千瓦时/万吨)</p>'+
													'</div>'+
													'<div class="tbox_bottom clear">'+
														'<div class="clear">'+
															'<p>昨日总量:</p><p>'+KPIDataAll+'</p>'+
														'</div>'+
														'<div class="clear">'+
															'<p>本月累计:</p><p>'+KPIDataAll+'</p>'+
														'</div>'+
													'</div>'+
												'</div>'+
												'<div class="tbox_contentrthree">'+
													'<div>'+KPIDataAll+'</div>'+
													'<div>'+
														'<span>环比:</span>'+
														'<span>'++'</span>'+
													'</div>'+
												'</div>'+
											'</div>'+
											'<div class="wancl">'+
												'<div class="wancl_tl">'+
													'<dl>'+
														'<dt><span class="big">'+KPIDataAll+'</span><span>%</span></dt>'+
														'<dd>月生产完成率</dd>'+
													'</dl>'+
												'</div>'+
												'<div class="wancl_tl">'+
													'<dl>'+
														'<dt><span class="big">'+KPIDataAll+'</span><span>%</span></dt>'+
														'<dd>月消耗完成率</dd>'+
													'</dl>'+
												'</div>'+
											'</div>';*/
			   				
			   			}
			   		});
	   			}
	   		}
	   		//$(".cy_navbox").append(chaYiFXNavData)

	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			//loading.hide();
            //loading.alertMsg('获取问题类型失败！');
		}
	});
	
	
	//曲线图
	function graphs(dataType){
		var KPIJson = {
	        AppID: "zb.s20170704000000001",
	        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipType: "iPhone",
	        IsEncrypted: 'false',
	        UserID: "test",
	        RequestMethod: "696969f2-bc52-4fec-bf9f-9859d528a750|c0b6aa04-da66-4f42-9b6a-3f56a221e123",
	        RequestParams: [{"value":"19003","key":"AreaId"},{"value":"1910000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-18","key":"DateTime"}]
	    }
			
		$.ajax({
		   	type: "post",
	        async: true,
	        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(KPIJson),
		   	success: function(msg){
		   		console.log(JSON.parse(msg))
		   		var dataTypeData = JSON.parse(msg);
		   		
		   		
		   		var qxAllData;
		   		
		   		//6种曲线图
		   		$.each(dataTypeData, function(i) {
		   			if(dataType == dataTypeData[i].id){
		   				console.log(dataTypeData[i].data)
		   				qxAllData = dataTypeData[i].data;
		   			}
		   		});
		   		
		   		var ziChanData;
		   		var waiGouData;
		   		var gongRuData;
		   		var xiaoHaoData;
		   		var waiGongData;
		   		var waiShouData;
		   		
		   		//各个曲线数据
		   		$.each(qxAllData, function(j) {
   					if(qxAllData[j].name == "自产"){
   						//console.log(qxAllData[j].data)
   						ziChanData = qxAllData[j].data;
   						
   					}
   					if(qxAllData[j].name == "外购"){
   						//console.log(qxAllData[j].data)
   						waiGouData = qxAllData[j].data;
   						
   					}
   					if(qxAllData[j].name == "供入"){
   						//console.log(qxAllData[j].data)
   						gongRuData = qxAllData[j].data;
   						
   					}
   					if(qxAllData[j].name == "消耗"){
   						//console.log(qxAllData[j].data)
   						xiaoHaoData = qxAllData[j].data;
   						
   					}
   					if(qxAllData[j].name == "供出"){
   						//console.log(qxAllData[j].data)
   						waiGongData = qxAllData[j].data;
   						
   					}
   					if(qxAllData[j].name == "外售"){
   						//console.log(qxAllData[j].data)
   						waiShouData = qxAllData[j].data;
   						
   					}
   					
   				});
   				
   				//echarts用的各个曲线数据
   				var ziChanDataArray = new Array();
		   		var waiGouDataArray = new Array();
		   		var gongRuDataArray = new Array();
		   		var xiaoHaoDataArray = new Array();
		   		var waiGongDataArray = new Array();
		   		var waiShouDataArray = new Array();
		   		var xName = new Array();
   				$.each(ziChanData, function(i) {
   					ziChanDataArray.push(ziChanData[i].y.toFixed(2))
   					xName.push(ziChanData[i].name)
   				});
   				$.each(waiGouData, function(i) {
   					waiGouDataArray.push(waiGouData[i].y.toFixed(2))
   				});
   				$.each(gongRuData, function(i) {
   					gongRuDataArray.push(gongRuData[i].y.toFixed(2))
   				});
   				$.each(xiaoHaoData, function(i) {
   					xiaoHaoDataArray.push(xiaoHaoData[i].y.toFixed(2))
   				});
   				$.each(waiGongData, function(i) {
   					waiGongDataArray.push(waiGongData[i].y.toFixed(2))
   				});
   				$.each(waiShouData, function(i) {
   					waiShouDataArray.push(waiShouData[i].y.toFixed(2))
   				});
   				console.log(xName)
   				
   				var sumj;
   				var sumc = [2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05, 2.05]
   				console.log(sumj)
   				console.log(sumc)
   				
   				$(".jx p").on("click",function(){
					//console.log($(this).text())
					if($(this).hasClass("active")){
						console.log("移除了")
						$(this).removeClass("active")
					} else {
						$(this).addClass("active")
					}
					
					Array.prototype.removeByValue = function(val) {
					  for(var i=0; i<this.length; i++) {
					    if(this[i] == val) {
					      this.splice(i, 1);
					      break;
					    }
					  }
					}
					
					if($(this).hasClass("active")){
						jArray.push($(this).text());
					} else {
						jArray.removeByValue($(this).text())
					}
					
					if(jArray.indexOf("外购") != -1 &&  jArray.indexOf("供入") == -1 && jArray.indexOf("自产") == -1){
						console.log("外购")
						console.log(waiGouDataArray)
						sumj = waiGouDataArray;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
					}
					if(jArray.indexOf("外购") == -1 && jArray.indexOf("供入") != -1 && jArray.indexOf("自产") == -1){
						console.log("供入")
						console.log(gongRuDataArray)
						sumj = gongRuDataArray;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
					}
					if(jArray.indexOf("外购") == -1 && jArray.indexOf("供入") == -1 && jArray.indexOf("自产") != -1){
						console.log("自产")
						console.log(ziChanDataArray)
						sumj = ziChanDataArray;
						echartsQX("",sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
					}
					if(jArray.indexOf("外购") != -1 &&  jArray.indexOf("供入") != -1 && jArray.indexOf("自产") == -1){
						console.log("外购+供入")

						for(i in waiGouDataArray){
							waiGouDataArray[i] = parseFloat(waiGouDataArray[i])
						}
						console.log(waiGouDataArray)
						for(i in gongRuDataArray){
							gongRuDataArray[i] = parseFloat(gongRuDataArray[i])
						}
						console.log(gongRuDataArray)
						
						var j = waiGouDataArray.map(function(v, i) {
						    return v + gongRuDataArray[i]
						})
						console.log(j)
						sumj = j;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
					}
					if(jArray.indexOf("外购") != -1 &&  jArray.indexOf("供入") == -1 && jArray.indexOf("自产") != -1){
						console.log("外购+自产")
						for(i in waiGouDataArray){
							waiGouDataArray[i] = parseFloat(waiGouDataArray[i])
						}
						console.log(waiGouDataArray)
						for(i in ziChanDataArray){
							ziChanDataArray[i] = parseFloat(ziChanDataArray[i])
						}
						console.log(ziChanDataArray)
						
						var j = waiGouDataArray.map(function(v, i) {
						    return v + ziChanDataArray[i]
						})
						console.log(j)
						sumj = j;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
					}
					if(jArray.indexOf("外购") == -1 &&  jArray.indexOf("供入") != -1 && jArray.indexOf("自产") != -1){
						console.log("供入+自产")
						for(i in gongRuDataArray){
							gongRuDataArray[i] = parseFloat(gongRuDataArray[i])
						}
						console.log(gongRuDataArray)
						for(i in ziChanDataArray){
							ziChanDataArray[i] = parseFloat(ziChanDataArray[i])
						}
						console.log(ziChanDataArray)
						
						var j = gongRuDataArray.map(function(v, i) {
						    return v + ziChanDataArray[i]
						})
						console.log(j)
						sumj = j;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
						
					}
					
					if(jArray.indexOf("外购") != -1 && jArray.indexOf("供入") != -1 && jArray.indexOf("自产") != -1){
						console.log("外购+供入+自产")
						for(i in gongRuDataArray){
							gongRuDataArray[i] = parseFloat(gongRuDataArray[i])
						}
						console.log(gongRuDataArray)
						for(i in ziChanDataArray){
							ziChanDataArray[i] = parseFloat(ziChanDataArray[i])
						}
						for(i in waiGouDataArray){
							waiGouDataArray[i] = parseFloat(waiGouDataArray[i])
						}
						
						var g = gongRuDataArray.map(function(v, i) {
						    return v + ziChanDataArray[i]
						})
						
						var j = g.map(function(v, i) {
						    return v + waiGouDataArray[i]
						})
						console.log(j)
						var sumj = j;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
						
					}
					if(jArray.length == 0){
						var sumj = [];
						echartsQX("",sumj,sumc)
					}
			
					
					console.log(jArray)
					
					
					
				})
   				
   				
   				//出项
   				$(".cx p").on("click",function(){
					//console.log($(this).text())
					if($(this).hasClass("active")){
						console.log("移除了")
						$(this).removeClass("active")
					} else {
						$(this).addClass("active")
					}
					
					Array.prototype.removeByValue = function(val) {
					  for(var i=0; i<this.length; i++) {
					    if(this[i] == val) {
					      this.splice(i, 1);
					      break;
					    }
					  }
					}
					
					if($(this).hasClass("active")){
						cArray.push($(this).text());
					} else {
						cArray.removeByValue($(this).text())
					}
					
					if(cArray.indexOf("消耗") != -1 &&  cArray.indexOf("外供") == -1 && cArray.indexOf("外售") == -1){
						console.log("消耗")
						console.log(xiaoHaoDataArray)
						sumc = xiaoHaoDataArray;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
					}
					if(cArray.indexOf("消耗") == -1 && cArray.indexOf("外供") != -1 && cArray.indexOf("外售") == -1){
						console.log("外供")
						console.log(waiGongDataArray)
						sumc = waiGongDataArray;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
					}
					if(cArray.indexOf("消耗") == -1 && cArray.indexOf("外供") == -1 && cArray.indexOf("外售") != -1){
						console.log("外售")
						console.log(waiShouDataArray)
						sumc = waiShouDataArray;
						echartsQX(xName,sumj,sumc)
					}
					if(cArray.indexOf("消耗") != -1 &&  cArray.indexOf("外供") != -1 && cArray.indexOf("外售") == -1){
						console.log("消耗+外供")

						for(i in xiaoHaoDataArray){
							xiaoHaoDataArray[i] = parseFloat(xiaoHaoDataArray[i])
						}
						console.log(xiaoHaoDataArray)
						for(i in waiGongDataArray){
							waiGongDataArray[i] = parseFloat(waiGongDataArray[i])
						}
						console.log(waiGongDataArray)
						
						var c = xiaoHaoDataArray.map(function(v, i) {
						    return v + waiGongDataArray[i]
						})
						console.log(c)
						sumc = c;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
					}
					if(cArray.indexOf("消耗") != -1 &&  cArray.indexOf("外供") == -1 && cArray.indexOf("外售") != -1){
						console.log("消耗+外售")
						for(i in xiaoHaoDataArray){
							xiaoHaoDataArray[i] = parseFloat(xiaoHaoDataArray[i])
						}
						console.log(xiaoHaoDataArray)
						for(i in waiShouDataArray){
							waiShouDataArray[i] = parseFloat(waiShouDataArray[i])
						}
						console.log(waiShouDataArray)
						
						var c = xiaoHaoDataArray.map(function(v, i) {
						    return v + waiShouDataArray[i]
						})
						console.log(c)
						sumc = c;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
					}
					if(cArray.indexOf("消耗") == -1 &&  cArray.indexOf("外供") != -1 && cArray.indexOf("外售") != -1){
						console.log("外供+外售")
						for(i in waiGongDataArray){
							waiGongDataArray[i] = parseFloat(waiGongDataArray[i])
						}
						console.log(waiGongDataArray)
						for(i in waiShouDataArray){
							waiShouDataArray[i] = parseFloat(waiShouDataArray[i])
						}
						console.log(waiShouDataArray)
						
						var c = waiShouDataArray.map(function(v, i) {
						    return v + waiGongDataArray[i]
						})
						console.log(c)
						sumc = c;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
						
					}
					
					if(cArray.indexOf("消耗") != -1 && cArray.indexOf("外供") != -1 && cArray.indexOf("外售") != -1){
						console.log("消耗+外供+外售")
						for(i in xiaoHaoDataArray){
							xiaoHaoDataArray[i] = parseFloat(xiaoHaoDataArray[i])
						}
						console.log(xiaoHaoDataArray)
						for(i in waiGongDataArray){
							waiGongDataArray[i] = parseFloat(waiGongDataArray[i])
						}
						for(i in waiShouDataArray){
							waiShouDataArray[i] = parseFloat(waiShouDataArray[i])
						}
						
						var g = waiShouDataArray.map(function(v, i) {
						    return v + waiGongDataArray[i]
						})
						
						var c = g.map(function(v, i) {
						    return v + xiaoHaoDataArray[i]
						})
						console.log(c)
						sumc = c;
						echartsQX(xName,sumj,sumc)
						console.log(sumj)
   						console.log(sumc)
						
					}
					if(cArray.length == 0){
						var sumc = [];
						echartsQX(xName,sumj,sumc)
					}
			
					
					console.log(cArray)
					
					
					
				})
   				
	
		   	},
		   	error: function (XMLHttpRequest, textStatus, errorThrown) {
				//loading.hide();
	            //loading.alertMsg('获取问题类型失败！');
			}
		});
	}
	
	
	
	
	//明细
	function details(dataType){
		var chDetailsJson = {
	        AppID: "zb.s20170704000000001",
	        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipType: "iPhone",
	        IsEncrypted: 'false',
	        UserID: "test",
	        RequestMethod: "696969f2-bc52-4fec-bf9f-9859d528a750|81418b59-e5ae-4351-be69-69bc655cb38d",
	        RequestParams: [{"value":"19003","key":"AreaId"},{"value":"1910000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-18","key":"DateTime"}]
	    }
			
		$.ajax({
		   	type: "post",
	        async: true,
	        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(chDetailsJson),
		   	success: function(msg){
		   		console.log(JSON.parse(msg))
		   		var detailsData = JSON.parse(msg);
		   		var detailsDome = '';
		   		//var dataTpye = 0;
		   		$.each(detailsData, function(i) {
		   			if(dataType == detailsData[i].Version){
		   				//console.log(detailsData[i])
		   				detailsDome += 	'<li>'+
											'<p>'+detailsData[i].AccuDicTypeName+'</p>'+
											'<p>'+detailsData[i].Desc+'</p>'+
											'<p>'+detailsData[i].Plan4Month+'</p>'+
											'<p>'+detailsData[i].DayComplate+'</p>'+
											'<p>'+detailsData[i].ComplateRate+'</p>'+
											'<p>'+detailsData[i].PlanTotal+'</p>'+
										'</li>';
		   			};
		   		});
		   		$(".fx_titleBox").empty();
		   		$(".fx_titleBox").append(detailsDome)
		   	},
		   	error: function (XMLHttpRequest, textStatus, errorThrown) {
				//loading.hide();
	            //loading.alertMsg('获取问题类型失败！');
			}
		});
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	function echartsQX(xName,sumj,sumc){
		echarts.dispose(document.getElementById('mainCH_1'));
		var chart = echarts.init(document.getElementById('mainCH_1'));
		var optionLine = {
		    tooltip : {
		        trigger: 'axis',
		        //backgroundColor: 'rgba(255,255,255,1)',
		        /*textStyle: {
		        	color:'#333333'
		        	
		        },*/
		        axisPointer : {
	                type : 'line',
	                lineStyle : {
	                    color: '#008acd'
	                },
	                crossStyle: {
	                    color: '#008acd'
	                },
	                shadowStyle : {
	                    color: 'rgba(200,200,200,0.3)'
	                }
	           	},
		        borderRadius: 4,
		        formatter: function (params) {
					//console.log(params)
					var res='<div><p style="color:#fff">'+params[0].name+'</p></div>' 
					for(var i=0;i<params.length;i++){
						res+=params[i].marker+'<span>'+params[i].seriesName+':'+params[i].data+'</span></br>';
					}
					return res;
				},
				//extraCssText: 'box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);',
		    },
		    grid: {  
		    	show: false,
		    	top:'22%',
			    left: '0%',  
			    right: '0%',  
			    bottom: '0%',  
			    containLabel: true ,
			    borderColor:'#fff',
			    shadowBlur :100,
			    shadowColor: 'red',
		        shadowOffsetX: 50,
		        shadowOffsetY: 80
			},
		    legend: {
		    	show: false,
		        data:['当前成本','优化成本'],
		        itemWidth: 20,
		        itemHeight: 8,
		        textStyle: {
					fontSize: 12,
				},
				//padding: 5,
				bottom: '0%',
				itemGap:20,
				
				
				//padding: 20,
		        
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
		            data : xName,//['5月29日','5月30日','5月31日','6月1日','6月2日','6月3日','6月4日','6月5日','6月6日','6月7日','6月8日','6月9日','6月10日','6月11日','6月12日','6月19日','6月26日'],
		            //data:[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18],
		            show : true,
		            axisLine:{
	                    show: true,
	                    lineStyle: {
	                    	type: 'solid',
	                    	color: "#eef2f9"
	                    }
	               	},
	               	//坐标轴字体颜色
	               	axisLabel: {
	                    show: true,
	                    interval: 6,//数据间隔
	                    margin: 15,
	                    textStyle: {
	                        color: '#89898e'
	                    },
	               	},
	               	splitLine : {show:false},
	               
	               	axisTick:{ 
	               		show:true,
	               		length:0
	               	} //去掉小横/竖杠
		        }
		    ],
		    yAxis : [
		    	{
		    		name:'万元      ',
		    		nameLocation:'end',
		    		nameTextStyle:{
		    			color:'#969696',
		    			fontSize: 12,
		    		},
		    		nameGap: 22,
		        	show : true,
		            type : 'value',
		            //splitNumber:2,
		            
		            //坐标轴颜色
		            axisLine:{
	                    show: false,
	                    lineStyle: {
	                    	show: true,
	                    	type: 'solid',
	                    	color: '#89898e'
	                    }
	               	},
	               	
	               	//坐标轴字体颜色
	               	axisLabel: {
	                    show: true,
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    formatter: '{value}'
	               },
	               
	               //坐标轴分割线
	               splitLine : {
	               		show:true,
	               		lineStyle:{
	               			color: ['#eee'],
	               		}
	               		
	               },
	               axisTick:{ show:false },//去掉小横/竖杠
		    	}
		    ],
		    series : [
		        {
		            name:'当前成本',
		            type:'line',
		            stack: '总量',
		            data:sumj,//[20, 17, 23, 16, 19,20, 17, 23, 16, 19,20, 17, 23, 16, 19,20, 17, 23, 16, 19,20, 17, 23, 16, 19],
		            symbolSize:4,
		            //symbolOffset:[6,6],
		            itemStyle: {
	                    normal: {
	                        color:"#a37bf2"
	                    }
	               	},
	               	/*markPoint : {
	               		symbolSize: 30,
		                data : [
		                    {type : 'max', name: '最大值'},
		                    {type : 'min', name: '最小值'}
		                ],
		                
		            },*/
		        },
		        {
		            name:'优化成本',
		            type:'line',
		            stack: '分分',
		            data:sumc,//[6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
		            itemStyle: {
	                    normal: {
	                        color:"#0099ff",
	                    }
	               	},
	               	/*markLine: {
		        		silent: true,
		        		type:'line',
						data: [{
				                    yAxis: 12,
				                    value: '达标线',
				                }],
				        symbolSize:[0,0]
						
		        	}*/
		        },
		        
		    ]
		};
		
		chart.setOption(optionLine);
		
		chart.on('click', function(param){
		 	console.log(param)
		 	console.log(param.name)
		 	console.log(param.seriesName)
		 
		});
	}
	
	

	
	
	
	
	
	
	
	
	
})