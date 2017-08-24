
$(function(){
	/*setTimeout(function(){
		$("body").css({"display":"block"})
	},1600)*/
	var loading = new Loading(); //进度条
	loading.show()
	var baseObj = new Base();
	var domainStr = baseObj.mainDomain;
	
	
	console.log(baseObj.formatTime("2017/7/24 17:00:09"))
	//表格数据
	var dlqubgParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "34c11e45-4d31-4ad6-b198-b088d27eb0cc|a2876720-747a-4b82-b017-53f7a3e1e3b4",
        RequestParams: [{"value":"2017-07-24","key":" urrdate"}]
    }
	
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(dlqubgParam),
	   	success: function(msg){
	   		console.log(JSON.parse(msg.d).Status)
	   		if(JSON.parse(msg.d).Status == "1"){
	   			console.log(JSON.parse(msg.d))
	   			loading.hide()
		   		var tbData = JSON.parse(msg.d).ResultDataInfos;
		   		var tbCurrCostData = new Array();//当前
		   		var tbOptCostData = new Array();//节约
		   		var tbSavingCostData = new Array();//优化
		   		var pieName = new Array();//饼图名称
		   		var tbdqDataAll = new Array();
		   		var bgData = "";
		   		$.each(tbData, function(i) {
		   			if(i>0){
		   				var tbCurrCostDataObj = {label:{
		   					normal:{
		   						textStyle:{
		   							fontSize:'10'
		   						}
		   					}
		   				}}
			   			tbCurrCostDataObj.value = tbData[i].CurrCost;
			   			tbCurrCostDataObj.name = tbData[i].OptimisedItem.substring(0, tbData[i].OptimisedItem.length - 2);
			   			tbCurrCostData.push(tbCurrCostDataObj)
			   			
			   			var tbOptCostDataObj = {label:{
		   					normal:{
		   						textStyle:{
		   							fontSize:'10'
		   						}
		   					}
		   				}}
			   			tbOptCostDataObj.value = tbData[i].OptCost;
			   			tbOptCostDataObj.name = tbData[i].OptimisedItem.substring(0, tbData[i].OptimisedItem.length - 2);
			   			tbOptCostData.push(tbOptCostDataObj)
			   			
			   			var tbSavingCostDataObj = {label:{
		   					normal:{
		   						textStyle:{
		   							fontSize:'10'
		   						}
		   					}
		   				}}
			   			tbSavingCostDataObj.value = tbData[i].SavingCost;
			   			tbSavingCostDataObj.name = tbData[i].OptimisedItem.substring(0, tbData[i].OptimisedItem.length - 2);
			   			tbSavingCostData.push(tbSavingCostDataObj)
						//debugger
						bgData += '<div class="dl_mx_conetnt clear">'+
								'<ul class="dl_mxleft clear">'+
									'<li class="clear" style="margin-top: .4rem;">'+
										'<p style="color: #333333; font-size: .32rem; text-align: left;">'+tbData[i].OptimisedItem+'</p>'+
									'</li>'+
									'<li class="clear">'+
										'<p>当前值:</p><p>'+tbData[i].CurrVal+'</p>'+
									'</li>'+
									'<li class="clear">'+
										'<p>优化值:</p><p>'+tbData[i].OptimisedVal+'</p>'+
									'</li>'+
								'</ul>'+
								'<ul class="dl_mxright clear">'+
									'<li class="clear" style="margin-top: .4rem;">'+
										'<p>节约成本:</p><p style="color: #005BAC;">'+tbData[i].SavingCost+'</p>'+
									'</li>'+
									'<li class="clear">'+
										'<p>当前成本</p><p>'+tbData[i].CurrCost+'</p>'+
									'</li>'+
									'<li class="clear">'+
										'<p>优化成本</p><p>'+tbData[i].OptCost+'</p>'+
									'</li>'+
								'</ul>'+
							'</div>';
		   				
		   			} else {
		   				if (JSON.parse(msg.d).Message != undefined || JSON.parse(msg.d).Message != '') {
		                    //loading.alertMsg(JSON.parse(msg.d).msg);
		                } else {
		                    //loading.alertMsg('获取问题类型失败！');
		                }
		   			}
		   		});	
		   		$(".listContent").append(bgData)
		   		console.log(tbCurrCostData)
		   		tbNavTab(tbCurrCostData)
		   		//debugger
		   		$(".dl_nav p").on("click",function(){
		   			$(this).addClass("dl_active").siblings().removeClass("dl_active")
		   			if($(this).text() == "当前成本"){
		   				tbNavTab(tbCurrCostData)
						tabName("总成本")	
						$(".addName_yh").text("24小时内总优化成本趋势")
		 				$(".addName_jy").text("24小时内总节约成本趋势")
						return
		   			} 
		   			if($(this).text() == "节约成本"){
		   				tbNavTab(tbSavingCostData)
		   				tabName("总成本")
		   				$(".addName_yh").text("24小时内总优化成本趋势")
		 				$(".addName_jy").text("24小时内总节约成本趋势")
		   				return
		   			} 
		   			if($(this).text() == "优化成本"){
		   				tbNavTab(tbOptCostData)
		   				tabName("总成本")
		   				$(".addName_yh").text("24小时内总优化成本趋势")
		 				$(".addName_jy").text("24小时内总节约成本趋势")
		   				return
		   			} 
		   		})
	   		}
	   		loading.hide()	
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    /*console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)*/
			
		}
	});
	
	
	
	
	function tbNavTab(CostArray){
		echarts.dispose(document.getElementById('dot'));//先销毁实例再创建,不然就会创建多个echarts实例
		var myChart = echarts.init(document.getElementById('dot'));
		myChart.showLoading()
		var option = {
		    title: {
		        text: '200565',
		        subtext: '总优化成本',
		        x: 'center',
		        y: 'center',
		        textStyle: {
		            fontSize: 24,
		            fontStyle: 'normal',
		            fontWeight: 'normal',
		        },
		        subtextStyle: {
		            fontSize: 12,
		            fontStyle: 'normal',
		            fontWeight: 'normal',
		        },
		        itemGap: -5,
		        padding: 50,
		    },
		    series: [
		        {
		            name:'成本',
		            type:'pie',
		            radius: ['42%', '58%'],
					center:['50%', '50%'],
		            data:CostArray,
		            itemStyle:{ 
		                normal:{ 
		                    label:{ 
		                       show: true, 
		                       formatter: ' {b}\n ({c})' 
		                    }, 
		                },
		            },
		            label:{
		            	normal:{
		            		show: true,
		            		position: 'outside',
		            	}
		            },
		            labelLine:{
		            	normal:{
		            		show: true,
		            		length:14,
		            		lineStyle:{
		            			color: '#969696',
		            			type: 'dashed',
		            		}
		            	}
		            	
		            },
		            
		        }
		    ]
		};
		myChart.on('click', function(param){
		 	tabName(param.name+"成本")
		 	$(".addName_yh").text("24小时内"+param.name+"优化成本趋势")
		 	$(".addName_jy").text("24小时内"+param.name+"节约成本趋势")
		});
		myChart.setOption(option);
		myChart.hideLoading()
	}
	
		//切换图标名字函数
	tabName("总成本")
	function tabName(name){
		console.log(name)
		var newDate = baseObj.formatNDate(new Date())
		var dlqustParam = {
	        AppID: "zb.s20170704000000001",
	        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipType: "iPhone",
	        IsEncrypted: 'false',
	        UserID: "test",
	        RequestMethod: "34c11e45-4d31-4ad6-b198-b088d27eb0cc|bd1d4856-4b95-4bd4-86ca-cd0085b45965",
	        RequestParams: [{"value":""+newDate+"","key":" currdate"},{"value":""+name+"","key":" unitcode"}]
	   	}
		console.log(dlqustParam)
		loading.show()
		$.ajax({
		   	type: "post",
	        async: true,
	        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(dlqustParam),
		   	success: function(msg){
		   		loading.hide()
		   		console.log(JSON.parse(msg.d))
		   		if(JSON.parse(msg.d).Status == "1"){
			   		var zData = JSON.parse(msg.d).ResultDataInfos;
			   		console.log(zData)
			   		var CurrCostArray = new Array();//当前成本 
			   		var OptCostArray = new Array();//优化成本 
			   		var xTimesArray = new Array();//X轴坐标
			   		var SavingCostArray = new Array()//节约成本
			   		$.each(zData, function(i) {
			   			/*if(){
			   				
			   			}*/
			   			CurrCostArray.push(zData[i].CurrCost/10000)
			   			OptCostArray.push(zData[i].OptCost/10000)
			   			xTimesArray.push(baseObj.formatTime(zData[i].Times))
			   			SavingCostArray.push(zData[i].SavingCost)
			   		});
			   		yhDate(CurrCostArray,OptCostArray,xTimesArray)
			   		jyDate(SavingCostArray,xTimesArray)
		   		} else {
		   			if (JSON.parse(msg.d).Message != undefined || JSON.parse(msg.d).Message != '') {
	                    loading.alertMsg(JSON.parse(msg.d).Message);
	                } else {
	                    loading.alertMsg('网络获取失败！');
	                }
		   		}
	   			
		   		
		   	},
		   	error: function (XMLHttpRequest, textStatus, errorThrown) {
				loading.hide();
            	loading.alertMsg('网络获取失败！');
				
			}
		});
	}

	
	//优化折线图
	function yhDate(CurrCostArray,OptCostArray,xTimesArray){
		echarts.dispose(document.getElementById('yhDate'));
		var chart = echarts.init(document.getElementById('yhDate'));
		chart.showLoading()
		var optionLine = {
		    tooltip : {
		        trigger: 'axis',
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
					var res='<div><p style="color:#fff">'+params[0].name+'</p></div>' 
					for(var i=0;i<params.length;i++){
						res+=params[i].marker+'<span>'+params[i].seriesName+':'+params[i].data+'</span></br>';
					}
					return res;
				},
		    },
		    grid: {  
		    	show: false,
		    	top:'18%',
			    left: '0%',  
			    right: '0%',  
			    bottom: '18%',  
			    containLabel: true ,
			    borderColor:'#fff',
			    shadowBlur :100,
			    shadowColor: 'red',
		        shadowOffsetX: 50,
		        shadowOffsetY: 80
			},
		    legend: {
		    	show: true,
		        data:['当前成本','优化成本'],
		        itemWidth: 20,
		        itemHeight: 8,
		        textStyle: {
					fontSize: 12,
				},
				bottom: '-2%',
				itemGap:6,
		        
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
		            data : xTimesArray,
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
		            data:CurrCostArray,
		            symbolSize:4,
		            itemStyle: {
	                    normal: {
	                        color:"#a37bf2"
	                    }
	               	},
		        },
		        {
		            name:'优化成本',
		            type:'line',
		            stack: '分分',
		            data:OptCostArray,
		            itemStyle: {
	                    normal: {
	                        color:"#0099ff",
	                    }
	               	},
		        },
		        
		    ]
		};
		
		chart.setOption(optionLine);
		chart.hideLoading()
	}
	
	
	//节约折线图
	function jyDate(SavingCostArray, xTimesArray){
		echarts.dispose(document.getElementById('jyDate'));
		var chart = echarts.init(document.getElementById('jyDate'));
		chart.showLoading()
		var optionLine = {
		    tooltip : {
		        trigger: 'axis',
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
		    	top:'18%',
			    left: '0%',  
			    right: '0%',  
			    bottom: '18%',  
			    containLabel: true ,
			    borderColor:'#fff',
			    shadowBlur :100,
			    shadowColor: 'red',
		        shadowOffsetX: 50,
		        shadowOffsetY: 80
			},
		    legend: {
		    	show: true,
		        data:['节约成本'],
		        itemWidth: 20,
		        itemHeight: 8,
		        textStyle: {
					fontSize: 12,
				},
				//padding: 5,
				bottom: '0%',
				itemGap:6,
				
				
				//padding: 20,
		        
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
		            data : xTimesArray,
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
		            name:'节约成本',
		            type:'line',
		            stack: '分分',
		            data:SavingCostArray,
		            itemStyle: {
	                    normal: {
	                        color:"#0099ff",
	                    }
	               	},

		        },
		        
		    ]
		};
		
		chart.setOption(optionLine);
		chart.hideLoading()
	}

})