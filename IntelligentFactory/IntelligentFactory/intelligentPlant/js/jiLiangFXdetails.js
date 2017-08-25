$(function(){
	/*setTimeout(function(){
		$("body").css({"display":"block"})
	},1600)*/
	var baseObj = new Base();
	var domainStr = baseObj.mainDomain;
	var loading = new Loading()
	zbsmbData()
	zbsData()
	var jzId = '1910000';
	
	
	var noticeCode = baseObj.getQuery(window.location.search, 'sjson');
	var cc = 0.23;
	//区域
	var eareAllJson = {
		"AppID":"zb.s20170704000000001",
		"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
		"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
		"EquipType":"iPhone",
		"IsEncrypted":"false",
		"UserID":"test",
		"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|7f0911a0-7fbf-48a2-aea5-45f618c10ce5",
		"RequestParams":[{"value":"0","key":"value1"}]
	}
	$.ajax({
		type: "post",
        async: true,
        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(eareAllJson),
        success: function(msg){
        	console.log(JSON.parse(msg))
        	var areaList = JSON.parse(msg).areaList;
        	var aa = '水务部';
	        $.each(areaList, function(i) {
	        	if(aa == areaList[i].text){
	        		console.log(333333)
	        	}
	        	if(aa != areaList[i].text){
	        		console.log(areaList[i].children)
	        	}
	        });

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    /*console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)*/
			
		}
        
	})
	
	//介质
	var jzAllJson = {
		"AppID":"zb.s20170704000000001",
		"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
		"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
		"EquipType":"iPhone",
		"IsEncrypted":"false",
		"UserID":"test",
		"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|e64bcabf-0b2b-4490-b2c6-7298a36ac4f6",
		"RequestParams":[{"value":"0","key":"value1"}]
	}
	$.ajax({
		type: "post",
        async: true,
        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(jzAllJson),
        success: function(msg){
        	console.log(JSON.parse(msg))

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    /*console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)*/
			
		}
        
	})
	
	//总表数面板汇总表  ========返回数据多了
	var zParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        //RequestMethod: "1b363376-cfba-4b3e-bc48-53e361f3de1e|ea7a0e1b-7cbd-4486-b76d-72a1bef9d73c",
        //RequestParams: [{"value":"2","key":"AreaId"},{"value":"1921000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-20","key":"DateTime"}]
        //RequestParams: [{"value":"2","key":"AreaId"},{"value":"1921000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-20","key":"DateTime"}]
       RequestMethod: "1b363376-cfba-4b3e-bc48-53e361f3de1e|ea7a0e1b-7cbd-4486-b76d-72a1bef9d73c",
       RequestParams: [{"value":"2","key":"AreaId"},{"value":"1921000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-18","key":"DateTime"}] 
        
   	}
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(zParam),
	   	success: function(msg){
	   		var KPIData = JSON.parse(msg);
	   		console.log(JSON.parse(msg))
	   		var aa = KPIData.VirtualMeterRate.toFixed(2)*100+"%"
	   		console.log(aa)
	   		var KPIElements = '<dl class="cBox">'+
									'<dt>'+((KPIData.DataAcquisitionRate).toFixed(2))*100+'%'+'</dt>'+
									'<dd>总数采率</dd>'+
								'</dl>'+
								'<dl class="cBox">'+
									'<dt>'+KPIData.DataAcquisitionNum+'</dt>'+
									'<dd>总数采个数</dd>'+
								'</dl>'+
								'<dl class="cBox">'+
									'<dt>'+((KPIData.EffectiveRate).toFixed(2))*100+'%'+'</dt>'+
									'<dd>有效率</dd>'+
								'</dl>'+
								'<dl class="cBox">'+
									'<dt>'+KPIData.ExpectedValue+'</dt>'+
									'<dd>预计值</dd>'+
								'</dl>'+
								'<dl class="cBox">'+
									'<dt>'+KPIData.AddMeterNum+'</dt>'+
									'<dd>增加表数</dd>'+
								'</dl>';
								
			$(".tabFX").append(KPIElements)	
			var zsclEl = '<div class="zb">'+
							'<p>总表数:</p>'+
							'<p>'+KPIData.MeterCount+'</p>'+
						'</div>'+
						'<ul class="zbc clear">'+
							'<li class="clear">'+
								'<p>虚表数:</p>'+
								'<p>'+KPIData.VirtualMeter+'</p>'+
							'</li>'+
							'<li>'+
								'<p>虚表率:</p>'+
								'<p>'+KPIData.VirtualMeterRate.toFixed(2)*100+'%'+'</p>'+
							'</li>'+
							'<li>'+
								'<p>实表数:</p>'+
								'<p>'+KPIData.RealMeter+'</p>'+
							'</li>'+
							'<li>'+
								'<p>实表率:</p>'+
								'<p>'+KPIData.RealMeterRate.toFixed(2)+'%'+'</p>'+
							'</li>'+
							'<li>'+
								'<p>预计值:</p>'+
								'<p>'+KPIData.ExpectedValue+'</p>'+
							'</li>'+
						'</ul>';			
			$(".FX_one").append(zsclEl)
			var zbsEl = '<div class="FX_twotop clear">'+
							'<p>总树采率:</p>'+
							'<p>'+KPIData.DataAcquisitionRate.toFixed(2)*100+'%'+'</p>'+
						'</div>'+
						'<ul class="FX_twobottom clear">'+
							'<li class="clear">'+
								'<p>实表数:</p>'+
								'<p>'+KPIData.RealMeter+'</p>'+
							'</li>'+
							'<li class="clear">'+
								'<p>人工预计:</p>'+
								'<p>'+KPIData.ManualExpect+'</p>'+
							'</li>'+
							'<li class="clear">'+
								'<p>人工录入:</p>'+
								'<p>'+KPIData.ManuaInput+'</p>'+
							'</li>'+
						'</ul>';
			$(".FX_two").append(zbsEl)
			var yxlEl = '<div class="FX_threec clear">'+
							'<p>有效个数:</p>'+
							'<p>'+KPIData.EffectiveNum+'</p>'+
						'</div>'+
						'<div class="FX_threec clear">'+
							'<p>数采个数:</p>'+
							'<p>'+KPIData.DataAcquisitionNum+'</p>'+
						'</div>';
			$(".FX_three").append(yxlEl)
			var yjzEl = '<ul class="FX_top clear">'+
							'<li class="clear">'+
								'<p>实表预计个数:</p>'+
								'<p>'+KPIData.RealExpectNum+'</p>'+
							'</li>'+
							'<li  class="clear">'+
								'<p>实表准确率:</p>'+
								'<p>'+KPIData.RealAccuracyRate.toFixed(4)*100+'%'+'</p>'+
							'</li>'+
						'</ul>'+
						'<ul class="FX_bottom">'+
							'<li  class="clear">'+
								'<p>虚表预计个数:</p>'+
								'<p>'+KPIData.VirtualExpectNum+'</p>'+
							'</li>'+
							'<li  class="clear">'+
								'<p>虚表准确率:</p>'+
								'<p>'+KPIData.VirtualAccuracyRate.toFixed(2)*100+'%'+'</p>'+
							'</li>'+
						'</ul>';
			$(".FX_four").append(yjzEl);
			var zjbsEl = '<ul class="FX_top clear">'+
							'<li class="clear">'+
								'<p>数采准确率:</p>'+
								'<p>'+KPIData.ExpectAccuracyRate.toFixed(2)*100+'%'+'</p>'+
							'</li>'+
							'<li  class="clear">'+
								'<p>增加实表数:</p>'+
								'<p>'+KPIData.AddRealMeter+'</p>'+
							'</li>'+
						'</ul>'+
						'<ul class="FX_bottom">'+
							'<li  class="clear">'+
								'<p>增加虚表数:</p>'+
								'<p>'+KPIData.AddVirtualMeter+'</p>'+
							'</li>'+
							'<li  class="clear">'+
								'<p>增加数采数:</p>'+
								'<p>'+KPIData.AddDataAcquisition+'</p>'+
							'</li>'+
						'</ul>';
			$(".FX_five").append(zjbsEl)
			$(".tabFX dl").on("click",function(){
		  		var thisIndex = $(this).index();
		  		$(this).addClass("FX_tabColor").siblings().removeClass("FX_tabColor")
		  		console.log(thisIndex)
		  		if(thisIndex == 0){
		  			zbsmbData()
		  			zbsData()
		  		}
		  		if(thisIndex == 1){
		  			zsclmbData()
		  			zsclBarData()
		  			
		  		}
		  		if(thisIndex == 2){
		  			yxlmbData()
		  			yxlBarData()
		  		}
		  		if(thisIndex == 3){
		  			yjzmbData()
		  		}
		  		/*if(thisIndex == 4){
		  			yxlmbData()
		  		}*/
		  		
		  		$.each($(".FX_sh>li"), function(i) {
		  			if(thisIndex == i){
		  				$(this).show(300).siblings().hide();
		  			}
		  		});
		  	});
		  	
		  	$(".FX_hide").on("click",function(){
		  		$(this).parent().hide(300)
		  	})
	   		
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    /*console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)*/
			
		}
	});
	
	
	
	//+----------------------------------------------------------------
    //| 总表数柱形图函数+ajax--开始
    //+----------------------------------------------------------------
	function zbsBar(VData,RData,xName){
		echarts.dispose(document.getElementById('main_s'));
		var myChartJl = echarts.init(document.getElementById('main_s'));
	  	var jlOption = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        data:['实表','虚表'],
		        bottom: 0,
		        itemWidth: 14,
		        itemHeight: 14,
		        textStyle: {
					fontSize: 14,
				},
				itemGap:20,
		    },
		    grid: {
		    	top: '16%',
		        left: '0%',
		        right: '0%',
		        bottom: '18%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : xName,
		            axisTick: {
		                //alignWithLabel: true,
		                show:false
		            },
		            //坐标轴线颜色
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
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    //margin: 8,
	               	},
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            name:'个',
		    		nameLocation:'end',
		    		nameTextStyle:{
		    			color:'#969696',
		    			fontSize: 12,
		    		},
		    		nameGap: 22,
		            axisTick: {
		                //alignWithLabel: true,
		                show:false
		            },
		            //坐标轴线颜色
		            axisLine:{
	                    show: false,
	                    lineStyle: {
	                    	type: 'solid',
	                    	color: "#eef2f9"
	                    }
	               	},
	               	//坐标轴字体颜色
	               	axisLabel: {
	                    show: true,
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    //margin: 8,
	               	},
	               	//max: 30,
		        }
		    ],
		    series : [
		        {
		            name:'实表',
		            type:'bar',
		            stack: 'gg',
		            barWidth: '46%',
		            label: {
						normal: {
							show: true,
							position: 'insideTop',
							textStyle:{
								color: '#fff',
								fontSize: 12,
							}
							
						}
					},
					itemStyle: {
						normal: {
							color: '#00a1eb',
						}
					},
		            data:VData
		        },
		        {
		            name:'虚表',
		            type:'bar',
		            barWidth: '46%',
		            stack: 'gg',
		            label: {
						normal: {
							show: true,
							position: 'insideTop',
							textStyle:{
								color: '#fff',
							}
						}
					},
					itemStyle: {
						normal: {
							color: '#f2901e',
						}
					},
		            data:RData
		        },
		    ]
		};
	
	  	myChartJl.setOption(jlOption);
	  	myChartJl.on('click', function(param){
			console.log(param)
		 	console.log(param.data.areaid)
		 	var AreaId = param.data.areaid;
		 	mxList(AreaId,jzId)
		});
	}
	
	function mxList(AreaId,jzId){
 		var strJson = {
            AppID: "zb.s20170704000000001",
            DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
            EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
            EquipType: "iPhone",
            IsEncrypted: 'false',
            UserID: "test",
            RequestMethod: "1b363376-cfba-4b3e-bc48-53e361f3de1e|5a4cc434-8cfc-4760-ac78-aeafae8697f2",//"54e36de2-18c2-43f4-ae7c-28348c141059|41a36aa1-d997-4ab2-894c-7eefad6e7f91",
            RequestParams: [{"value":AreaId,"key":"AreaId"},{"value":jzId,"key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-18","key":"DateTime"}]
        }
		
		$.ajax({
		   	type: "post",
	        async: true,
	        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(strJson),
		   	success: function(msg){
		   		$(".fx_titleBox").empty()
		   		console.log(JSON.parse(msg))
		   		var mxListData = JSON.parse(msg).meterDetailList;
		   		var mxListDome = "";
		   		$.each(mxListData, function(i) {
		   			mxListDome += 	'<li>'+
										'<p>'+mxListData[i].areaName+'</p>'+
										'<p>'+mxListData[i].meterName+'</p>'+
										'<p>'+mxListData[i].stationNum+'</p>'+
										//'<p>'+mxListData[i].stationNum+'</p>'+
										'<p>'+mxListData[i].preMeterData+'/'+mxListData[i].aftMeterData+'</p>'+
										'<p>'+mxListData[i].isUpdate+'</p>'+
									'</li>';
		   		});
		   		$(".fx_titleBox").append(mxListDome)
		   	},
		   	error: function (XMLHttpRequest, textStatus, errorThrown) {
				//loading.hide();
	            //loading.alertMsg('获取问题类型失败！');
			}
		});
 	}
	
  	function zbsData(){
  		var eareJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|c8e6782c-bfc0-4bf7-97bc-55ae5b5ba419",
			"RequestParams": [{"value":"5461,5462,5463,5464,5465,6097","key":" AreaIdList"},{"value":"-3","key":" Condition1"},{"value":"1","key":" DateType"},{"value":"2017-06-18","key":" DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(eareJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	var barData = JSON.parse(msg);
	        	var VData = new Array();
	        	var RData = new Array();
	        	var xName = new Array();
	        	var VObj = {namme:"",value:"",id:""};
	        	$.each(barData, function(i) {
	        		VData.push({namme:"",value:barData[i].V.y,areaid:barData[i].V.areaid})
	        		RData.push({namme:"",value:barData[i].R.y,areaid:barData[i].R.areaid})
	        		xName.push(barData[i].R.areaname)
	        	});
	        	console.log(VData)
	        	zbsBar(VData,RData,xName)
	
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
	        
		})
  	}
  	//+----------------------------------------------------------------
    //| 总表数柱形图函数+ajax--结束
    //+----------------------------------------------------------------

	//+----------------------------------------------------------------
    //| 总数采率柱形图函数+ajax--开始
    //+----------------------------------------------------------------
	function zsclBarData(){
		loading.show()
		var zsclBarJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|fa84b36d-d8b1-4a74-b193-74659bf8a0e5",
			"RequestParams": [{"value":"5461,5462,5463,5464,5465,6097","key":" AreaIdList"},{"value":"-3","key":" Condition1"},{"value":"1","key":" DateType"},{"value":"2017-06-18","key":" DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(zsclBarJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	var zsclBarAllData = JSON.parse(msg);
	        	var zsclBarData = new Array();
	        	var zsclBarxName = new Array();
	        	$.each(zsclBarAllData, function(i) {
	        		zsclBarData.push(zsclBarAllData[i].x)
	        		zsclBarxName.push(zsclBarAllData[i].areaname)
	        	});
	        	console.log(zsclBarData)
	        	console.log(zsclBarxName)
	        	zsclBar(zsclBarData,zsclBarxName)
				loading.hide()
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
	        
		})
	}
	
	function zsclBar(zsclBarData,zsclBarxName){
		echarts.dispose(document.getElementById('main_s'));
		var myChartJl = echarts.init(document.getElementById('main_s'));
	  	var jlOption = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        data:['总数采率'],
		        bottom: 0,
		        itemWidth: 14,
		        itemHeight: 14,
		        textStyle: {
					fontSize: 14,
				},
				itemGap:20,
		    },
		    grid: {
		    	top: '16%',
		        left: '0%',
		        right: '0%',
		        bottom: '18%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : zsclBarxName,
		            axisTick: {
		                //alignWithLabel: true,
		                show:false
		            },
		            //坐标轴线颜色
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
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    //margin: 8,
	               	},
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            name:'个',
		    		nameLocation:'end',
		    		nameTextStyle:{
		    			color:'#969696',
		    			fontSize: 12,
		    		},
		    		nameGap: 22,
		            axisTick: {
		                //alignWithLabel: true,
		                show:false
		            },
		            //坐标轴线颜色
		            axisLine:{
	                    show: false,
	                    lineStyle: {
	                    	type: 'solid',
	                    	color: "#eef2f9"
	                    }
	               	},
	               	//坐标轴字体颜色
	               	axisLabel: {
	                    show: true,
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    //margin: 8,
	               	},
	               	//max: 30,
		        }
		    ],
		    series : [
		        {
		            name:'总数采率',
		            type:'bar',
		            stack: 'gg',
		            barWidth: '46%',
		            label: {
						normal: {
							show: true,
							position: 'insideTop',
							textStyle:{
								color: '#fff',
								fontSize: 12,
							}
							
						}
					},
					itemStyle: {
						normal: {
							color: '#00a1eb',
						}
					},
		            data:zsclBarData
		        },
		    ]
		};
	
	  	myChartJl.setOption(jlOption);
	}
	
	//+----------------------------------------------------------------
    //| 总数采率柱形图函数+ajax--结束
    //+----------------------------------------------------------------
  	
  	
  	//+----------------------------------------------------------------
    //| 有效率柱形图函数+ajax--开始
    //+----------------------------------------------------------------
    
	function yxlBarData(){
		loading.show()
		var yxlBarJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|f4760370-4d94-48bd-b1d3-725acbec8a03",
			"RequestParams": [{"value":"5461,5462,5463,5464,5465,6097","key":" AreaIdList"},{"value":"-3","key":" Condition1"},{"value":"1","key":" DateType"},{"value":"2017-06-18","key":" DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(yxlBarJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	var yxlBarAllData = JSON.parse(msg);
	        	var yxlBarData = new Array();
	        	var yxlBarxName = new Array();
	        	$.each(yxlBarAllData, function(i) {
	        		yxlBarData.push((yxlBarAllData[i].y).toFixed(2))
	        		yxlBarxName.push(yxlBarAllData[i].areaname)
	        	});
	        	console.log(yxlBarData)
	        	zsclBar(yxlBarData,yxlBarxName)
	        	loading.hide()
	
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
	        
		})
	}
	
	function yxlBar(yxlBarData,yxlBarxName){
		echarts.dispose(document.getElementById('main_s'));
		var myChartJl = echarts.init(document.getElementById('main_s'));
	  	var jlOption = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        data:['总数采率'],
		        bottom: 0,
		        itemWidth: 14,
		        itemHeight: 14,
		        textStyle: {
					fontSize: 14,
				},
				itemGap:20,
		    },
		    grid: {
		    	top: '16%',
		        left: '0%',
		        right: '0%',
		        bottom: '18%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : yxlBarxName,
		            axisTick: {
		                //alignWithLabel: true,
		                show:false
		            },
		            //坐标轴线颜色
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
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    //margin: 8,
	               	},
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            name:'个',
		    		nameLocation:'end',
		    		nameTextStyle:{
		    			color:'#969696',
		    			fontSize: 12,
		    		},
		    		nameGap: 22,
		            axisTick: {
		                //alignWithLabel: true,
		                show:false
		            },
		            //坐标轴线颜色
		            axisLine:{
	                    show: false,
	                    lineStyle: {
	                    	type: 'solid',
	                    	color: "#eef2f9"
	                    }
	               	},
	               	//坐标轴字体颜色
	               	axisLabel: {
	                    show: true,
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    //margin: 8,
	               	},
	               	//max: 30,
		        }
		    ],
		    series : [
		        {
		            name:'有效率',
		            type:'bar',
		            stack: 'gg',
		            barWidth: '46%',
		            label: {
						normal: {
							show: true,
							position: 'insideTop',
							textStyle:{
								color: '#fff',
								fontSize: 12,
							}
							
						}
					},
					itemStyle: {
						normal: {
							color: '#00a1eb',
						}
					},
		            data:yxlBarData
		        },
		    ]
		};
	
	  	myChartJl.setOption(jlOption);
	}
	//+----------------------------------------------------------------
    //| 总数采率柱形图函数+ajax--结束
    //+----------------------------------------------------------------
  	
  	
  	//+----------------------------------------------------------------
    //| 预计值总数柱形图函数+ajax--开始
    //+----------------------------------------------------------------
    yjzzsBarData()
	function yjzzsBarData(){
		loading.show()
		var yjzzsBarJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|26d3e32a-34b5-499f-b8e0-62ca595c35d6",
			"RequestParams": [{"value":"5461,5462,5463,5464,5465,6097","key":" AreaIdList"},{"value":"-3","key":" Condition1"},{"value":"1","key":" DateType"},{"value":"2017-06-18","key":" DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(yjzzsBarJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	/*var yxlBarAllData = JSON.parse(msg);
	        	var yxlBarData = new Array();
	        	var yxlBarxName = new Array();
	        	$.each(yxlBarAllData, function(i) {
	        		yxlBarData.push((yxlBarAllData[i].y).toFixed(2))
	        		yxlBarxName.push(yxlBarAllData[i].areaname)
	        	});
	        	console.log(yxlBarData)
	        	zsclBar(yxlBarData,yxlBarxName)*/
	        	loading.hide()
	
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)
				
			}
	        
		})
	}
	
	function yxlBar(yxlBarData,yxlBarxName){
		echarts.dispose(document.getElementById('main_s'));
		var myChartJl = echarts.init(document.getElementById('main_s'));
	  	var jlOption = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        data:['总数采率'],
		        bottom: 0,
		        itemWidth: 14,
		        itemHeight: 14,
		        textStyle: {
					fontSize: 14,
				},
				itemGap:20,
		    },
		    grid: {
		    	top: '16%',
		        left: '0%',
		        right: '0%',
		        bottom: '18%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : yxlBarxName,
		            axisTick: {
		                //alignWithLabel: true,
		                show:false
		            },
		            //坐标轴线颜色
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
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    //margin: 8,
	               	},
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            name:'个',
		    		nameLocation:'end',
		    		nameTextStyle:{
		    			color:'#969696',
		    			fontSize: 12,
		    		},
		    		nameGap: 22,
		            axisTick: {
		                //alignWithLabel: true,
		                show:false
		            },
		            //坐标轴线颜色
		            axisLine:{
	                    show: false,
	                    lineStyle: {
	                    	type: 'solid',
	                    	color: "#eef2f9"
	                    }
	               	},
	               	//坐标轴字体颜色
	               	axisLabel: {
	                    show: true,
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    //margin: 8,
	               	},
	               	//max: 30,
		        }
		    ],
		    series : [
		        {
		            name:'有效率',
		            type:'bar',
		            stack: 'gg',
		            barWidth: '46%',
		            label: {
						normal: {
							show: true,
							position: 'insideTop',
							textStyle:{
								color: '#fff',
								fontSize: 12,
							}
							
						}
					},
					itemStyle: {
						normal: {
							color: '#00a1eb',
						}
					},
		            data:yxlBarData
		        },
		    ]
		};
	
	  	myChartJl.setOption(jlOption);
	}
	//+----------------------------------------------------------------
    //| 预计值总数柱形图函数+ajax--结束
    //+----------------------------------------------------------------
  	
  	
  	//+----------------------------------------------------------------
    //| 增加表数柱形图函数--开始
    //+----------------------------------------------------------------
    zjbsBarData()
    function zjbsBarData(){
		loading.show()
		var zjbsBarJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|009b0099-fe57-46c5-a607-45737eb97371",
			"RequestParams": [{"value":"5461,5462,5463,5464,5465,6097","key":" AreaIdList"},{"value":"-3","key":" Condition1"},{"value":"1","key":" DateType"},{"value":"2017-06-18","key":" DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(zjbsBarJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	/*var yxlBarAllData = JSON.parse(msg);
	        	var yxlBarData = new Array();
	        	var yxlBarxName = new Array();
	        	$.each(yxlBarAllData, function(i) {
	        		yxlBarData.push((yxlBarAllData[i].y).toFixed(2))
	        		yxlBarxName.push(yxlBarAllData[i].areaname)
	        	});
	        	console.log(yxlBarData)
	        	zsclBar(yxlBarData,yxlBarxName)*/
	        	loading.hide()
	
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)
				
			}
	        
		})
	}
    
  	function zjbsBar(yxlBarData,yxlBarxName){
  		echarts.dispose(document.getElementById('main_s'));
		var myChartJl = echarts.init(document.getElementById('main_s'));
	  	var jlOption = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        data:['总数采率'],
		        bottom: 0,
		        itemWidth: 14,
		        itemHeight: 14,
		        textStyle: {
					fontSize: 14,
				},
				itemGap:20,
		    },
		    grid: {
		    	top: '16%',
		        left: '0%',
		        right: '0%',
		        bottom: '18%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : yxlBarxName,
		            axisTick: {
		                //alignWithLabel: true,
		                show:false
		            },
		            //坐标轴线颜色
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
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    //margin: 8,
	               	},
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            name:'个',
		    		nameLocation:'end',
		    		nameTextStyle:{
		    			color:'#969696',
		    			fontSize: 12,
		    		},
		    		nameGap: 22,
		            axisTick: {
		                //alignWithLabel: true,
		                show:false
		            },
		            //坐标轴线颜色
		            axisLine:{
	                    show: false,
	                    lineStyle: {
	                    	type: 'solid',
	                    	color: "#eef2f9"
	                    }
	               	},
	               	//坐标轴字体颜色
	               	axisLabel: {
	                    show: true,
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    //margin: 8,
	               	},
	               	//max: 30,
		        }
		    ],
		    series : [
		        {
		            name:'有效率',
		            type:'bar',
		            stack: 'gg',
		            barWidth: '46%',
		            label: {
						normal: {
							show: true,
							position: 'insideTop',
							textStyle:{
								color: '#fff',
								fontSize: 12,
							}
							
						}
					},
					itemStyle: {
						normal: {
							color: '#00a1eb',
						}
					},
		            data:yxlBarData
		        },
		    ]
		};
	
	  	myChartJl.setOption(jlOption);
	}
	//+----------------------------------------------------------------
    //| 增加表数柱形图函数--结束
    //+----------------------------------------------------------------
  	
  	mxbData()
  	function mxbData(){
		loading.show()
		var mxbJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|5a4cc434-8cfc-4760-ac78-aeafae8697f2",
			"RequestParams": [{"value":"5461","key":"AreaId"},{"value":"-3","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-18","key":"DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(mxbJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	/*var yxlBarAllData = JSON.parse(msg);
	        	var yxlBarData = new Array();
	        	var yxlBarxName = new Array();
	        	$.each(yxlBarAllData, function(i) {
	        		yxlBarData.push((yxlBarAllData[i].y).toFixed(2))
	        		yxlBarxName.push(yxlBarAllData[i].areaname)
	        	});
	        	console.log(yxlBarData)
	        	zsclBar(yxlBarData,yxlBarxName)*/
	        	loading.hide()
	
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)
				
			}
	        
		})
	}
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	function zbsmbData(){
  		loading.show()
  		var zbsmbJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|7f7169eb-98d7-43ee-97d7-fd3ed2ff1157",
			"RequestParams": [{"value":"5461,5462,5463,5464,5465,6097","key":" AreaIdList"},{"value":"-3","key":" Condition1"},{"value":"1","key":" DateType"},{"value":"2017-06-18","key":" DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(zbsmbJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	var zbsmbListData = JSON.parse(msg);
	        	var zbsmbDome =""
	        	$.each(zbsmbListData, function(i) {
	        		zbsmbDome +='<li>'+
									'<p>'+zbsmbListData[i].area+'</p>'+
									'<p>'+(zbsmbListData[i].DataAccuracy).toFixed(2)+'/'+(zbsmbListData[i].RealMeterExpectValue).toFixed(2)+'/'+(zbsmbListData[i].RealMeterRG).toFixed(2)+'</p>'+
									'<p>'+(zbsmbListData[i].VirtualMeterExpectValue).toFixed(2)+'/'+(zbsmbListData[i].VirtualMeterRG).toFixed(2)+'</p>'+
								'</li>';
	        	});
	        	$(".FX_Onecntent").empty();
				$(".FX_Onecntent").append(zbsmbDome);
				loading.hide()
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
	        
		})
  	}
	zsclmbData()
  	function zsclmbData(){
  		//loading.show()
  		var zsclmbJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|5a2b8a0c-78cf-4521-a6ff-86b9bf91ee79",
			"RequestParams": [{"value":"5461,5462,5463,5464,5465,6097","key":" AreaIdList"},{"value":"-3","key":" Condition1"},{"value":"1","key":" DateType"},{"value":"2017-06-18","key":" DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(zsclmbJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	var zsclmbListData = JSON.parse(msg);
	        	console.log(zsclmbListData)
	        	var zsclmbDome =""
	        	$.each(zsclmbListData, function(i) {
	        		zsclmbDome += '<li>'+
	        						'<p>'+zsclmbListData[i].area+'</p>'+
									'<p>'+(zsclmbListData[i].DataRate).toFixed(2)+'</p>'+
									'<p>'+(zsclmbListData[i].DataCollectMeter).toFixed(2)+'</p>'+
									'<p>'+(zsclmbListData[i].RealMeter).toFixed(2)+'/'+(zsclmbListData[i].RealMeterExpectValue).toFixed(2)+'/'+(zsclmbListData[i].RealMeterRG).toFixed(2)+'</p>'+
								'</li>';
	        	});
	        	$(".FX_Twocntent").empty();
				$(".FX_Twocntent").append(zsclmbDome);
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
	        
		})
  	};
  	
  	function yxlmbData(){
  		loading.show()
  		var yxlmbJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|8f50b0be-6157-4b68-bdca-667d306c5db3",
			"RequestParams": [{"value":"5461,5462,5463,5464,5465,6097","key":" AreaIdList"},{"value":"-3","key":" Condition1"},{"value":"1","key":" DateType"},{"value":"2017-06-18","key":" DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(yxlmbJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	var yxlmbListData = JSON.parse(msg);
	        	var yxlmbDome =""
	        	$.each(yxlmbListData, function(i) {
	        		yxlmbDome +='<li>'+
									'<p>'+yxlmbListData[i].area+'</p>'+
									'<p>'+yxlmbListData[i].ExpectRate+'</p>'+
									'<p>'+yxlmbListData[i].ExpectNum+'</p>'+
									'<p>'+yxlmbListData[i].DataAccuracyNum+'</p>'+
								'</li>';
	        	});
	        	$(".FX_Threecntent").empty();
				$(".FX_Threecntent").append(yxlmbDome);
				loading.hide()
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
	        
		})
  	};
  	function yjzmbData(){
  		loading.show()
  		var yjzmbJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|2536bf71-df4c-41f1-ae13-a19a7fe8f1d8",
			"RequestParams": [{"value":"5461,5462,5463,5464,5465,6097","key":" AreaIdList"},{"value":"-3","key":" Condition1"},{"value":"1","key":" DateType"},{"value":"2017-06-18","key":" DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(yjzmbJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	var yjzmbListData = JSON.parse(msg);
	        	var yjzmbDome =""
	        	$.each(yjzmbListData, function(i) {
	        		yjzmbDome += '<li>'+
									'<p>'+yjzmbListData[i].area+'</p>'+
									'<p>'+yjzmbListData[i].ExpectNum+'</p>'+
									'<p>'+yjzmbListData[i].UpdateyNum+'</p>'+
									'<p>'+yjzmbListData[i].NoUpdateNum+'</p>'+
								'</li>';
	        	});
	        	$(".FX_Fourcntent").empty();
				$(".FX_Fourcntent").append(yjzmbDome);
				loading.hide()
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
	        
		})
  	}
  	
  	function mxbmbData(){
  		var zbsmbJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"1b363376-cfba-4b3e-bc48-53e361f3de1e|5a4cc434-8cfc-4760-ac78-aeafae8697f2",
			"RequestParams": [{"value":"5461,5462,5463,5464,5465,6097","key":" AreaIdList"},{"value":"-3","key":" Condition1"},{"value":"1","key":" DateType"},{"value":"2017-06-18","key":" DateTime"}]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(zbsmbJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	var zbsmbListData = JSON.parse(msg);
	        	var zbsmbDome =""
	        	$.each(zbsmbListData, function(i) {
	        		zbsmbDome +='<li>'+
									'<p>'+zbsmbListData[i].area+'</p>'+
									'<p>'+(zbsmbListData[i].DataAccuracy).toFixed(2)+'/'+(zbsmbListData[i].RealMeterExpectValue).toFixed(2)+'/'+(zbsmbListData[i].RealMeterRG).toFixed(2)+'</p>'+
									'<p>'+(zbsmbListData[i].VirtualMeterExpectValue).toFixed(2)+'/'+(zbsmbListData[i].VirtualMeterRG).toFixed(2)+'</p>'+
								'</li>';
	        	});
	        	$(".FX_Onecntent").empty();
				$(".FX_Onecntent").append(zbsmbDome);
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
	        
		})
  	}
  	
  	
})