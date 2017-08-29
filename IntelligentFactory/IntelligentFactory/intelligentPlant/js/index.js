$(function(){
	/*setTimeout(function(){
		$("body").css({"display":"block"})
	},1600)*/
	var baseObj = new Base();
	
	//初始化给<label></label>标签赋值为当前时间
	$("label").text(baseObj.formatNDate(new Date()))
	var changeData = $("label").text();
	
	$(".select").change(function(){
		if($(".select").val() == ''){
			$("label").text(baseObj.formatNDate(changeData))
			changeData = $("label").text()
		} else {
			$("label").text(baseObj.formatNDate($(".select").val()))
			changeData = $("label").text()
		}
	})
	
	
	/*var myChart = echarts.init(document.getElementById('main'));
				var optionBar = {
					grid: {  
					    left: '2%',  
					    right: '8%',  
					    bottom: '14%', 
					    top:'4%',
					    containLabel: true ,
					},
				    tooltip : {
				    	show: false,
				        trigger: 'axis',
				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				            type : 'shadow',        // 默认为直线，可选为：'line' | 'shadow'
				            label:{
				            	show:false,
				            	formatter: '{value}'
				            }
				        },
				        triggerOn:'mousemove',
				        confine: true,
				        formatter: function (params) {
							console.log(params)
							var res='<div><p style="color:red">'+params[0].name+'</p></div>' 
							for(var i=0;i<params.length;i++){
								if(i==2||i==6){
									
								}else{
									res+=params[i].marker+'<span>'+params[i].seriesName+':'+params[i].data+'</span></br>'
								}
								
							}
							return res;
						},
				    },
				    legend: {
				    	selectedMode:false,
				    	data: ["自产", "外购", "供入", "消耗", "外供", "外售"],
				        itemWidth: 12,
				        itemHeight: 12,
				        textStyle: {
							fontSize: 10,
						},
						bottom: -10,
						padding: 18,
						itemGap:14,
						
				    },
				    yAxis : [
				        {	
				        	boundaryGap: [0, 0.1],
				        	data:["新鲜水(t)"],
				        	//data:["新鲜水(t)"],
				            type : 'category',
				            splitLine : {show:false},
				            //去掉小横/竖杠
				            axisTick:{ show:false },
				            //坐标轴线的颜色
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
		                        }
		                   }
				        },
				        
				    ],
				    xAxis : [
				        {	
				        	show : true,
				            type : 'value',
				            margin: 15,
				            //scale: true,
				            axisLine:{
			                    show: true,
			                    interval:0,
			                    margin: 15,
			                    lineStyle: {
			                    	type: 'solid',
			                    	color: "#eef2f9"
			                    },
			                    onZero: true,
			               	},
			               	//坐标轴字体颜色
			               	axisLabel: {
		                        show: true,
		                        margin: 15,
		                        textStyle: {
		                            color: '#89898e'
		                        },
		                        interval:0,
		                   	},
			               	splitLine : {show:false},
			               	//max: 300,
			               	axisTick:{ show:false } //去掉
			               	
				        }
				        
				        
				        
				    ],
				    series : [
				        {
				            name:'自产',
				            type:'bar',
				            stack: 'sum',
				            barWidth : '26',
							barCategoryGap: 200,
				            data:[50],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 7
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#00a1eb"
			                    }
			                    
			               },
				           //data:msg.all.series[0].data,//这里
				           barGap:'20%'
				        },
				        {
				            name:'外购',
				            barWidth : '26',
				            type:'bar',
				            stack: 'sum',
				            data:[50],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight',		      
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#00baef",	
			                    },
			               	},
				           //data:msg.all.series[1].data,
				           barGap:'20%'
				        },
				        {
				            name:'供入',
				            barWidth : '26',
				            type:'bar',
				            stack: 'sum',
				            data:[40],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight',		      
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#89def5",
			                    },
			               	},
				           //data:msg.all.series[1].data,
				           barGap:'20%'
				        },
				        {
				            name: '总和',
				            barWidth : '26',
				            type: 'bar',
				            stack: 'sum',
				            data:[0],
				            label: {
				
				                normal: {
				                    offset:['50', '80'],
				                    show: true,
				                    position: 'insideLeft',
				                    //formatter:'{c}',
				                    textStyle:{
				                        color:'#000'
				                    }
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:'rgba(128, 128, 128, 0)',
			                        label : {
				                        show: true, 
				                        position: 'right',
				                        formatter: function (params) {		            
				                            for (var i = 0, l = optionBar.yAxis[0].data.length; i < l; i++) {
				                                if (optionBar.yAxis[0].data[i] == params.name) {
				                                   	var sum = 0;
				                                   	optionBar.series.map(function (item,index,input) {
				                                   		if(index <= 2){
				                                   			//console.log(index)
				                                   			sum += optionBar.series[index].data[i];
				                                   		};
													});
				                                    return sum
				                                }
				
				                            }
				                        },
				                        
			                    	},	
			                    },
			               	},
				            //data:[0,0,0],
			        	},
				        //============================stack: '总量',=================================
				        {
				            name:'消耗',
				            type:'bar',
				            barWidth : '26',//设置第一个的宽度后面的宽度跟第一个的宽度走
				            stack: '总量',
				            data:[50],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#f08200"
			                    }
			               },
				            //data:msg.all.series[3].data,
				            barGap:'20%'
				        },
				        {
				            name:'外供',
				            type:'bar',
				            barWidth : '26',
				            stack: '总量',
				            data:[50],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#fcaa56"
			                    }
			               },
				            //data:msg.all.series[4].data,
				            barGap:'20%'
				        },
				        {
				            name:'外售',
				            type:'bar',
				            barWidth : '26',
				            stack: '总量',
				            data:[50],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#fdcea2"
			                    }
			              	},
				            barGap:'20%'
				        },
			        	{
				            name: '总和2',
				            barWidth : '26',
				            type: 'bar',
				            stack: '总量',
				            data:[0],
				            label: {
				
				                normal: {
				                    offset:['50', '80'],
				                    show: true,
				                    position: 'insideLeft',
				                    //formatter:'{c}',
				                    textStyle:{
				                        color:'#000'
				                    }
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:'rgba(128, 128, 128, 0)',
			                        label : {
				                        show: true, 
				                        position: 'right',
				                        formatter: function (params) {		            
				                            for (var i = 0, l = optionBar.yAxis[0].data.length; i < l; i++) {
				                                if (optionBar.yAxis[0].data[i] == params.name) {
				                                   	var sum = 0;
				                                   	optionBar.series.map(function (item,index,input) {
				                                   		if(index > 3){
				                                   			//console.log(index)
				                                   			sum += optionBar.series[index].data[i];
				                                   		};
													});
				                                    return sum
				                                }
				
				                            }
				                        },
				                        
			                    	},	
			                    },
			               },
			        	}
				        
				    ]
				};
				
				myChart.setOption(optionBar);*/

	
	
	ecaData("day")
	//能源产耗分析	
	function ecaData(tabName){	
		var strJson = {
            AppID: "zb.s20170704000000001",
            DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
            EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
            EquipType: "iPhone",
            IsEncrypted: 'false',
            UserID: "test",
            RequestMethod: "54e36de2-18c2-43f4-ae7c-28348c141059|41a36aa1-d997-4ab2-894c-7eefad6e7f91",
            RequestParams: [{ "value": "0", "key": "value1" }]
        }
		
		$.ajax({
		   	type: "post",
            async: true,
            url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
            contentType: "application/x-www-form-urlencoded",
            data: JSON.stringify(strJson),
		   	success: function(msg){
		   		console.log(msg)
		   		echarts.dispose(document.getElementById('main'));
				var myChart = echarts.init(document.getElementById('main'));
				var optionBar = {
					grid: {  
					    left: '2%',  
					    right: '8%',  
					    bottom: '18%', 
					    top:'6%',
					    containLabel: true ,
					},
				    tooltip : {
				    	show: false,
				        trigger: 'axis',
				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				            type : 'shadow',        // 默认为直线，可选为：'line' | 'shadow'
				            label:{
				            	show:false,
				            	formatter: '{value}'
				            }
				        },
				        triggerOn:'mousemove',
				        confine: true,
				        formatter: function (params) {
							console.log(params)
							var res='<div><p style="color:red">'+params[0].name+'</p></div>' 
							for(var i=0;i<params.length;i++){
								if(i==2||i==6){
									
								}else{
									res+=params[i].marker+'<span>'+params[i].seriesName+':'+params[i].data+'</span></br>'
								}
								
							}
							return res;
						},
				    },
				    legend: {
				    	selectedMode:false,
				    	data: ["自产", "外购", "供入", "消耗", "外供", "外售"],
				        itemWidth: 12,
				        itemHeight: 12,
				        textStyle: {
							fontSize: 10,
						},
						bottom: -10,
						padding: 18,
						itemGap:14,
						
				    },
				    yAxis : [
				        {	
				        	boundaryGap: [0, 0.1],
				        	data:["新鲜水(t)", "电(kw.h)", "蒸汽(t)"],
				        	//data:["新鲜水(t)"],
				            type : 'category',
				            splitLine : {show:false},
				            //去掉小横/竖杠
				            axisTick:{ show:false },
				            //坐标轴线的颜色
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
		                        }
		                   }
				        },
				        
				    ],
				    xAxis : [
				        {	
				        	show : true,
				            type : 'value',
				            margin: 15,
				            //scale: true,
				            axisLine:{
			                    show: true,
			                    interval:0,
			                    margin: 15,
			                    lineStyle: {
			                    	type: 'solid',
			                    	color: "#eef2f9"
			                    },
			                    onZero: true,
			               	},
			               	//坐标轴字体颜色
			               	axisLabel: {
		                        show: true,
		                        margin: 15,
		                        textStyle: {
		                            color: '#89898e'
		                        },
		                        interval:0,
		                   	},
			               	splitLine : {show:false},
			               	//max: 300,
			               	axisTick:{ show:false } //去掉
			               	
				        }
				        
				        
				        
				    ],
				    series : [
				        {
				            name:'自产',
				            type:'bar',
				            stack: 'sum',
				            barWidth : '26',
							barCategoryGap: 200,
				            data:[50,60,70],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 7
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#00a1eb"
			                    }
			                    
			               },
				           //data:msg.all.series[0].data,//这里
				           barGap:'20%'
				        },
				        {
				            name:'外购',
				            barWidth : '26',
				            type:'bar',
				            stack: 'sum',
				            data:[50,60,70],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight',		      
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#00baef",	
			                    },
			               	},
				           //data:msg.all.series[1].data,
				           barGap:'20%'
				        },
				        {
				            name:'供入',
				            barWidth : '26',
				            type:'bar',
				            stack: 'sum',
				            data:[40,50,60],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight',		      
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#89def5",
			                    },
			               	},
				           //data:msg.all.series[1].data,
				           barGap:'20%'
				        },
				        {
				            name: '总和',
				            barWidth : '26',
				            type: 'bar',
				            stack: 'sum',
				            data:[0,0,0],
				            label: {
				
				                normal: {
				                    offset:['50', '80'],
				                    show: true,
				                    position: 'insideLeft',
				                    //formatter:'{c}',
				                    textStyle:{
				                        color:'#000'
				                    }
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:'rgba(128, 128, 128, 0)',
			                        label : {
				                        show: true, 
				                        position: 'right',
				                        formatter: function (params) {		            
				                            for (var i = 0, l = optionBar.yAxis[0].data.length; i < l; i++) {
				                                if (optionBar.yAxis[0].data[i] == params.name) {
				                                   	var sum = 0;
				                                   	optionBar.series.map(function (item,index,input) {
				                                   		if(index <= 2){
				                                   			//console.log(index)
				                                   			sum += optionBar.series[index].data[i];
				                                   		};
													});
				                                    return sum
				                                }
				
				                            }
				                        },
				                        
			                    	},	
			                    },
			               	},
				            //data:[0,0,0],
			        	},
				        //============================stack: '总量',=================================
				        {
				            name:'消耗',
				            type:'bar',
				            barWidth : '26',//设置第一个的宽度后面的宽度跟第一个的宽度走
				            stack: '总量',
				            data:[50,60,70],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#f08200"
			                    }
			               },
				            //data:msg.all.series[3].data,
				            barGap:'20%'
				        },
				        {
				            name:'外供',
				            type:'bar',
				            barWidth : '26',
				            stack: '总量',
				            data:[50,60,70],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#fcaa56"
			                    }
			               },
				            //data:msg.all.series[4].data,
				            barGap:'20%'
				        },
				        {
				            name:'外售',
				            type:'bar',
				            barWidth : '26',
				            stack: '总量',
				            data:[50,60,70],
				            label: {
				                normal: {
				                    show: true,
				                    position: 'insideRight'
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:"#fdcea2"
			                    }
			              	},
				            barGap:'20%'
				        },
			        	{
				            name: '总和2',
				            barWidth : '26',
				            type: 'bar',
				            stack: '总量',
				            data:[0,0,0],
				            label: {
				
				                normal: {
				                    offset:['50', '80'],
				                    show: true,
				                    position: 'insideLeft',
				                    //formatter:'{c}',
				                    textStyle:{
				                        color:'#000'
				                    }
				                }
				            },
				            itemStyle: {
			                    emphasis: {
			                        barBorderRadius: 0
			                    },
			                    normal: {
			                        barBorderRadius:[2, 2, 2, 2],
			                        color:'rgba(128, 128, 128, 0)',
			                        label : {
				                        show: true, 
				                        position: 'right',
				                        formatter: function (params) {		            
				                            for (var i = 0, l = optionBar.yAxis[0].data.length; i < l; i++) {
				                                if (optionBar.yAxis[0].data[i] == params.name) {
				                                   	var sum = 0;
				                                   	optionBar.series.map(function (item,index,input) {
				                                   		if(index > 3){
				                                   			//console.log(index)
				                                   			sum += optionBar.series[index].data[i];
				                                   		};
													});
				                                    return sum
				                                }
				
				                            }
				                        },
				                        
			                    	},	
			                    },
			               },
			        	}
				        
				    ]
				};
		   		if(tabName == 'day'){
		   			console.log("这是day的数据")
		   			var listData = msg.list;
			   		var ProductionNodeDataDay = [];//自产
			   		var OutsourcingNodeDataDay = [];//外购
			   		var ConsumptionNodeDataDay = [];//消耗
			   		var ForeignsalesNodeDataDay = [];//外售
			   		var TransferNodeDataDay = [];//外供
			   		$.each(listData, function(i) {
			   			ProductionNodeDataDay.push((listData[i].ProductionNodeDataDay).toFixed(2));
			   			OutsourcingNodeDataDay.push((listData[i].OutsourcingNodeDataDay).toFixed(2));
			   			ConsumptionNodeDataDay.push((listData[i].ConsumptionNodeDataDay).toFixed(2));
			   			ForeignsalesNodeDataDay.push((listData[i].ForeignsalesNodeDataDay).toFixed(2));
			   			TransferNodeDataDay.push((listData[i].TransferNodeDataDay).toFixed(2));
			   		});
			   		console.log(ProductionNodeDataDay)
			   		optionBar.series[0].data = ProductionNodeDataDay;
			   		optionBar.series[1].data = OutsourcingNodeDataDay;
			   		optionBar.series[2].data = OutsourcingNodeDataDay;
			   		optionBar.series[3].data = [0,0,0];
			   		optionBar.series[4].data = ConsumptionNodeDataDay;
			   		optionBar.series[5].data = TransferNodeDataDay;
			   		optionBar.series[6].data = ForeignsalesNodeDataDay;
			   		optionBar.series[7].data = [0,0,0];
			   		
			   		//数据处理完以后生成实例
			   		myChart.setOption(optionBar);
		   		} else if(tabName == "month"){
					console.log("这是month的数据")
					var listData = msg.list;
			   		var ProductionNodeDataMonth = [];//自产
			   		var OutsourcingNodeDataMonth = [];//外购
			   		var ConsumptionNodeDataMonth = [];//消耗
			   		var ForeignsalesNodeDataMonth = [];//外售
			   		var TransferNodeDataMonth = [];//外供
			   		$.each(listData, function(i) {
			   			ProductionNodeDataMonth.push(listData[i].ProductionNodeDataMonth);
			   			OutsourcingNodeDataMonth.push(listData[i].OutsourcingNodeDataMonth);
			   			ConsumptionNodeDataMonth.push(listData[i].ConsumptionNodeDataMonth);
			   			ForeignsalesNodeDataMonth.push(listData[i].ForeignsalesNodeDataMonth);
			   			TransferNodeDataMonth.push(listData[i].TransferNodeDataMonth);
			   		});
			   		optionBar.series[0].data = ProductionNodeDataMonth;
			   		optionBar.series[1].data = OutsourcingNodeDataMonth;
			   		optionBar.series[2].data = OutsourcingNodeDataMonth;
			   		optionBar.series[3].data = [0,0,0];
			   		optionBar.series[4].data = ConsumptionNodeDataMonth;
			   		optionBar.series[5].data = TransferNodeDataMonth;
			   		optionBar.series[6].data = ForeignsalesNodeDataMonth;
			   		optionBar.series[7].data = [0,0,0];
			   		
			   		//数据处理完以后生成实例
			   		myChart.setOption(optionBar);
				}
	   			
		   		
		   	},
		   	error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
		});
	}
		
	//ecaData("day")
	$(".right_tab p").on("click",function(){
		console.log($(this).attr("data-tab"))
		$(this).addClass("nh_active").siblings().removeClass("nh_active");
		if($(this).attr("data-tab") == "day"){
			ecaData('day')
		} else if($(this).attr("data-tab") == "month") {
			ecaData('month')
		}
	})
			
	//能源成本优化	
	function nycbyhCheats(xNameArray,CurrCostData,OptCostData){
		var chart = echarts.init(document.getElementById('mainZ'));
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
					console.log(params)
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
		            data : xNameArray,
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
		    		name:'万元',
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
		            data:CurrCostData,
		            symbolSize:4,
		            //symbolOffset:[6,6],
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
		            data:OptCostData,
		            itemStyle: {
	                    normal: {
	                        color:"#0099ff",
	                    }
	               	},
		        },
		        
		    ]
		};
		chart.setOption(optionLine);
	}
	
	
	var strJson = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",	
        RequestMethod: "54e36de2-18c2-43f4-ae7c-28348c141059|ccf5b2ff-3d03-41d7-b41b-83f272f5535e",
        RequestParams: [{"value":"2017-06-30","key":"currdate"}]
    }
	
	$.ajax({
	   	type: "post",
        async: true,
        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(strJson),
	   	success: function(msg){
	   		console.log(JSON.parse(msg.d))
	   		var nycbyhDate = JSON.parse(msg.d).ResultDataInfos[0];
	   		console.log(nycbyhDate)
	   		$(".dqcb").text(nycbyhDate.CurrCost)//当前成本
	   		$(".yhcb").text(nycbyhDate.OptCost)//优化成本
	   		$(".shownumber").text(nycbyhDate.SavingCost)//节约成本
	   		var ny_yshowinnerWid = (nycbyhDate.OptCost/nycbyhDate.CurrCost).toFixed(4)
	   		$(".ny_yshowinner").width(ny_yshowinnerWid*100+"%")
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    /*console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)*/
			
		}
	});
	
	var nycbyParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "34c11e45-4d31-4ad6-b198-b088d27eb0cc|bd1d4856-4b95-4bd4-86ca-cd0085b45965",
        RequestParams: [{"value":"2017-07-23","key":" currdate"},{"value":"总成本","key":" unitcode"}]
    }
	
	$.ajax({
	   	type: "post",
        async: true,
        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(nycbyParam),
	   	success: function(msg){
	   		console.log(JSON.parse(msg.d))
	   		//xTimesArray.push(baseObj.formatTime(zData[i].Times))
	   		var nyResultDataInfosData = JSON.parse(msg.d).ResultDataInfos;
	   		var xNameArray = new Array();
	   		var CurrCostData = new Array();//当前成本
	   		var OptCostData = new Array();//优化成本
	   		$.each(nyResultDataInfosData, function(i) {
	   			CurrCostData.push(nyResultDataInfosData[i].CurrCost);
	   			OptCostData.push(nyResultDataInfosData[i].OptCost);
	   			xNameArray.push(baseObj.formatTime(nyResultDataInfosData[i].Times))
	   		});
   			console.log(OptCostData)
   			/*optionLine.xAxis.data = xNameArray;
   			optionLine.series[0].data = CurrCostData;
   			optionLine.series[1].data = OptCostData;*/
   			
   			nycbyhCheats(xNameArray,CurrCostData,OptCostData)
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    /*console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)*/
			
		}
	});
	
  	//能源指标
	energyTar()
	function energyTar(){
		var strJson = {"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"54e36de2-18c2-43f4-ae7c-28348c141059|f1d127a4-6314-45d9-9117-8a566080c244",
			"RequestParams":[{"value":"0","key":"value1"}]
		}
		
		$.ajax({
			type: "post",
            async: true,
            url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
            contentType: "application/x-www-form-urlencoded",
            data: JSON.stringify(strJson),
            success: function(msg){
            	console.log(msg)
            	var dataMsg = msg.list;
            	var title = '';
            	$.each(dataMsg, function(i) {
            		title += '<li>'+
								'<p>'+dataMsg[i].StandardValueMonthTotal+'</p>'+
								'<p>'+dataMsg[i].IndexName+'</p>'+
							'</li>';
            	});
            	function tabData(number){
            		var DayValueList = [];
            		var TimeList = [];
            		var StandardValueMonthTotal = 0;
        			$.each(dataMsg, function(i) {
	            		if(number == i){
	            			$.each(dataMsg[i].TimeList, function(i,c) {
	            				if(c.substr(c.length-1,1) == "月"){
	            					TimeList.push(c)
	            				} else {
	            					TimeList.push(c+"日")
	            				}
	            			});
	            			DayValueList = dataMsg[i].DayValueList;	
	            			StandardValueMonthTotal = dataMsg[i].StandardValueMonthTotal 
	            		}
	            	});
	            	console.log(StandardValueMonthTotal)
	            	echarts.dispose(document.getElementById('main_ny'));
	            	var myChartBarNy = echarts.init(document.getElementById('main_ny'));
					// 指定图表的配置项和数据
					//多系列层叠，个性化样式，代码如下：
					var nyOption = {
					    color: ['#3398DB'],
					    tooltip : {
					    	show:false,
					        trigger: 'axis',
					        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
					        }
					    },
					    grid: {
					        left: '0%',
					        right: '9%',
					        bottom: '4%',
					        top: '20%',
					        containLabel: true
					    },
					    dataZoom: [{
					    	show: false,
					        type: 'inside',
					        start: 0,
					        end: 22,
					        /*minSpan: 22,*/
							maxSpan: 22,
					    }],
					    xAxis : [
					        {
					            type : 'category',
					            name:'日',
					    		nameLocation:'end',
					            data : TimeList,//['1日','2日', '3日', '4日', '5日', '6日', '7日','8日','9日', '10日', '11日', '12日', '13日', '14日'],
					            boundaryGap:true,
					            //boundaryGap: ['80%', '20%'],
					            axisTick: {
					                alignWithLabel: true,
					                show:true,
					                length: 7,
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
				                    margin: 15,
				                    textStyle: {
				                        color: '#89898e'
				                    },
				                    //margin: 8,
				               	},
				               	
					        }
					    ],
					    yAxis : [
					        {
					        	name:'万吨',
					    		nameLocation:'end',
					    		nameTextStyle:{
					    			color:'#969696'
					    		},
					    		nameGap:24,
					            type : 'value',
					            axisTick:{ show:false },
					            axisLabel : {
					                formatter: '{value}',
					                //margin: 80,
					            },
					            splitNumber:5,
					           	//控制y轴线是否显示
								axisLine: {show: false},
								// 控制网格线是否显示
								splitLine: {
									show: true,
									//网线的颜色
									lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
						                color: '#eef2f9',
						                width: 1,
						                type: 'solid'
					            	}
								},
								// 去除y轴上的刻度线
								axisTick: {
									show: false
								},
								//max: 150,
					            
					        }
					    ],
					    series : [
					        {
					            name:'直接访问',
					            type:'bar',
					            barWidth: '60%',
					            stack: '数据',
					            data:DayValueList,//[226, 160, 170, 180, 240, 180, 260,226, 160, 170, 180, 240, 180, 260],
					            zlevel:3,
					            label:{
					            	normal:{
					            		textStyle: {
					                    	color: '#4b4b4b',
					                    	
					                    }
					            	}
					            	
					            },
					            itemStyle: {
				                    normal: {
				                    	show:false,
				                        color:"#00a83c",
				                        shadowColor: 'rgba(0, 0, 0, 0.5)',
				    					//shadowBlur: 10,
										//shadowOffsetX: 10,
										//shadowOffsetY: 10,
				                        //柱形图顶部显示数值
				                        label : {show: true, position: 'top'},
				                        //barBorderRadius: [80, 20, 5, 5]
				                        
				                    }
				               	},
					        },
					        /*{
					            name:'hh',
					            type:'bar',
					            barWidth: '60%',
					            stack: '数据',
					            zlevel:3,
					            data:[1000, 5200, 1000, 1340, 9000, 13000, 12000],
					            itemStyle: {
				                    normal: {
				                        color:'rgba(0,0,0,0)',
				                        //柱形图顶部显示数值
				                        label : {show: true, position: 'bottom'}
				                    }
				               	},
				               	label: {
					
					                normal: {
					                    offset:['50', '80'],
					                    show: true,
					                    position: 'insideBottom',
					                    //formatter:'{c}',
					                    textStyle:{
					                        color:'#000'
					                    }
					                }
					            },
					        },*/
					        {
					        	name:'标准线',
					        	type:'line',
					        	markLine: {
					        		silent: true,
					        		symbolSize:0,
					        		type:'line',
									itemStyle: {
					        			normal: {
					        				lineStyle: {
												color: '#ff0000',
												//type: 'solid',
												width: 1,
												shadowColor: 'rgba(0,0,0,0)',
												shadowBlur: 0,
											},
					        			}
					        			
					        		},
					        		z: 1,
									data: [{	
												value:'标准线',
							                    yAxis: StandardValueMonthTotal,
							                    name: '标准线',
							             },
									
									]	
					        	}
					        }
					    ]
					};
					
					
					// 使用刚指定的配置项和数据显示图表。
					myChartBarNy.setOption(nyOption);
					myChartBarNy.on('click', function(param){
						console.log(param)
					 	console.log(param.name)
					});
            	}
            	tabData(0)
            	$(".nyBox").append(title)
            	$(".nyBox li:first-child").addClass("nyactiv");
            	var thisIndex = 0
        		$(".nyBox li").on("click",function(){
        			thisIndex = $(this).index();
            		$(this).addClass("nyactiv").siblings().removeClass("nyactiv")
					tabData(thisIndex)
					return
            	})
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
		});
		
		
		
		
		
		
	}

  	
  	
  	//重要装置能耗对标	
  	zzdb()
  	function zzdb(){
  		var myChartBarNH = echarts.init(document.getElementById('main_zznh'));
		// 指定图表的配置项和数据
		//多系列层叠，个性化样式，代码如下：
		var zzOption = {
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        },
			        /*formatter: function (params) {
							console.log(params)
							var res='<div><p style="color:red">'+params[0].name+'</p></div>' 
							for(var i=0;i<params.length;i++){
								if(i==2||i==6){
									
								}else{
									res+=params[i].marker+'<span>'+params[i].seriesName+':'+params[i].data+'</span></br>'
								}
								
							}
							return res;
						},
				    },*/
			    },
			    dataZoom: [/*{
			    	show: false,
			        type: 'inside',
			        start: 0,
			        end: 22,
			        minSpan: 22,
					maxSpan: 22,
					},*/
					{
		                show: false,
		                yAxisIndex: 0,
		                filterMode: 'empty',
		                width: 30,
		                height: '80%',
		                showDataShadow: false,
		                left: '93%'
		            }
			    ],
			    legend: {
			    	show: false,
			        data: ['直接访问', '邮件营销','联盟广告','视频广告','搜索引擎']
			    },
			    grid: {
			        left: '0%',
			        right: '10%',
			        top: '10%',
			        bottom: '0%',
			        containLabel: true
			    },
			    xAxis:  {	
		        	show : true,
		            type : 'value',
		            name:'%',
		    		nameLocation:'end',
		    		nameTextStyle:{
		    			color:'#969696',
		    			fontSize: 12,
		    		},
		            margin: 15,
		            //scale: true,
		            axisLine:{
	                    show: true,
	                    interval:0,
	                    margin: 15,
	                    lineStyle: {
	                    	type: 'solid',
	                    	color: "#eef2f9"
	                    },
	                    onZero: true,
	               	},
	               	//坐标轴字体颜色
	               	axisLabel: {
                        show: true,
                        margin: 15,
                        textStyle: {
                            color: '#89898e'
                        },
                        interval:0,
                   	},
	               	splitLine : {show:false},
	               	//max: 300,
	               	axisTick:{ show:false }, //去掉
	               	max: 800,
	               	
		        },
			    yAxis: {
			        type: 'category',
			        //data: ['周丰东股份一','周二','周三','周四','周五','周六','周日'],
			        axisTick:{ show:false },
		            axisLabel : {
		                formatter: '{value}',
		                //margin: 80,
		            },
		            splitNumber:5,
		           	//控制y轴线是否显示
					axisLine: {show: false},
					// 控制网格线是否显示
					splitLine: {
						show: false,
						//网线的颜色
						lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
			                color: '#eef2f9',
			                width: 1,
			                type: 'solid'
		            	}
					},
					// 去除y轴上的刻度线
					axisTick: {
						show: false
					},
			    },
			    series: [
			        {
			            name: '达标率',
			            type: 'bar',
			            //barWidth: '26%',
			            //barCategoryGap: '40%',
			            stack: 'sum',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'insideRight',
			                    formatter: '{c}%' 
			                }
			            },
			            itemStyle:{ 
			                normal:{ 
			                	barBorderRadius:[2, 2, 2, 2],
			                	color: '#01a7eb',
			                    label:{ 
			                       show: true, 
			                       formatter: '{d}%\n({c})' 
			                    }, 
			                    labelLine :{show:true}
			                } 
			            },
			            //data: [320, 302, 301, 334, 390, 330, 320]
			        },
			        {
			            name: '总能耗',
			            //barWidth: '26%',
			            //barCategoryGap: '40%',
			            type: 'bar',
			            stack: 'sum',
			            //data:[0,0,0],
			            label: {
			
			                normal: {
			                    offset:['50', '80'],
			                    show: true,
			                    position: 'insideLeft',
			                    //formatter:'{c}',
			                    textStyle:{
			                        color:'#000'
			                    }
			                }
			            },
			            itemStyle: {
		                    emphasis: {
		                        barBorderRadius: 0
		                    },
		                    normal: {
		                        barBorderRadius:[2, 2, 2, 2],
		                        color:'rgba(128, 128, 128, 0)',
		                        label : {
			                        show: true, 
			                        position: 'right',
			                        /*formatter: function (params) {		            
			                            for (var i = 0, l = optionBar.yAxis[0].data.length; i < l; i++) {
			                                if (optionBar.yAxis[0].data[i] == params.name) {
			                                   	var sum = 0;
			                                   	optionBar.series.map(function (item,index,input) {
			                                   		if(index <= 2){
			                                   			//console.log(index)
			                                   			sum += optionBar.series[index].data[i];
			                                   		};
												});
			                                    return sum
			                                }
			
			                            }
			                        },*/
			                        
		                    	},	
		                    },
		               	},
			            //data:[0,0,0],
		        	},
			        {
			        	name:'标准线',
			        	type:'line',
			        	markLine: {
			        		silent: true,
			        		symbolSize:0,
			        		type:'line',
							itemStyle: {
			        			normal: {
			        				lineStyle: {
										color: '#ff0000',
										//type: 'solid',
										width: 1,
										shadowColor: 'rgba(0,0,0,0)',
										shadowBlur: 0,
									},
			        			}
			        			
			        		},
			        		z: 1,
							data: [{	
										value:'标准线',
					                    xAxis: 100,
					                    name: '标准线',
					             },
							
							]	
			        	}
			        }
			        
			    ]
			};
		
		
		var strJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"54e36de2-18c2-43f4-ae7c-28348c141059|a80253e0-27e8-410f-ada6-e4887d701d11",
			"RequestParams":[{"value":"0","key":"value1"}]
		}
		$.ajax({
			type: "post",
            async: true,
            url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
            contentType: "application/x-www-form-urlencoded",
            data: JSON.stringify(strJson),
            success: function(msg){
            	console.log(msg)
            	var nhdbData = msg.list;
            	var UnitNameArray = new Array();
            	var RealValueArray = new Array();
            	var xNameArray = new Array();
            	$.each(nhdbData, function(i) {
            		RealValueArray.push((nhdbData[i].RealValue).toFixed(2));
            		UnitNameArray.push(nhdbData[i].UnitName)
            		xNameArray.push((nhdbData[i].RealValue/nhdbData[i].StandardValue*100).toFixed(2))
            	});
            	
            	var xMax = Math.max.apply(null, xNameArray)
            	zzOption.xAxis.max = xMax+200;
            	zzOption.series[0].data = xNameArray;
            	zzOption.series[1].data = RealValueArray;
            	zzOption.yAxis.data = UnitNameArray;
            	//zzOption.series[1].data[0].xAxis = 100
            	console.log(zzOption)
            	
            	// 使用刚指定的配置项和数据显示图表。
				myChartBarNH.setOption(zzOption);
            	
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
            
		})
		myChartBarNH.on('click', function(param){
			console.log(param)
		 	console.log(param.name)
		 	//console.log(option.xAxis[param.seriesIndex].data[param.dataIndex])
		});
		
  	}
  	
  	
	//仪表盘-能源结构
	var nyjgParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "54e36de2-18c2-43f4-ae7c-28348c141059|1ade613b-dd50-4dd1-99e2-0152de3a8a0d",
       RequestParams: [{"value":"6921","key":" FacId"},{"value":"1","key":" calendarType "},{"value":"2017-01-01","key":" start"},{"value":"2017-01-01","key":" end"}]
    }
	
	$.ajax({
	   	type: "post",
        async: true,
        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(nyjgParam),
	   	success: function(msg){
	   		console.log(msg)
	   		var nyxhData = msg.Data;
	   		console.log(nyxhData)
	   		var nyxhDataArray = new Array();
	   		var colorArray = ["#01a7eb","#f2901e","#77c06e","#e94347","#7179cb"]
	   		$.each(nyxhData, function(i) {
	   			var nyxhDataObj = {itemStyle: {
		                    normal: {
		                        color:colorArray[i],
		                    }
		               	}}
	   			nyxhDataObj.value = nyxhData[i].Value;
	   			nyxhDataObj.name = nyxhData[i].Name;
	   			nyxhDataArray.push(nyxhDataObj)

	   		});
	   		
	   		console.log(nyxhDataArray)
		  	var myChartMg = echarts.init(document.getElementById('main_mg'));
			var MgOption = {
			    tooltip : {
			    	show: false,
			        trigger: 'item',
			        formatter: function (name) {
			        	console.log(name)
					    return 'Legend ' + name.percent+'('+name.value+')';
					},
					//alwaysShowContent:true,
			    },
			    legend: {
			        data:[ {
				                name:'电',
				                icon : 'circle',
				                //textStyle:{fontWeight:'bold', color:'#01a7eb'}
				            },{
				                name:'水',
				                icon : 'circle',
				                //textStyle:{fontWeight:'bold', color:'green'}
				            },{
				                name:'蒸汽',
				                icon : 'circle',
				                //textStyle:{fontWeight:'bold', color:'green'}
				            },{
				                name:'燃料',
				                icon : 'circle',
				                //textStyle:{fontWeight:'bold', color:'green'}
				            },{
				                name:'风',
				                icon : 'circle',
				                //textStyle:{fontWeight:'bold', color:'green'}
				            },'rose1','rose2','rose3','rose4','rose5'],
			        orient: 'horizontal',
			        itemWidth: 10,
			        itemHeight: 10,
			        textStyle: {
						fontSize: 14,
					},
					itemGap:20,
					bottom: '0%',
					icon : 'scatter',
					trigger: 'axis',
					formatter: function (name) {
						console.log(name)
				        return echarts.format.truncateText(name, 40, '14px Microsoft Yahei', '…');
				    },
				    tooltip: {
				        show: true
				    }
			    },
			   	clickable: false,
			    legendHoverLink: true,
			    selectedOffset: 100,
			    series : [
			        {
			            name: '访问来源',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '40%'],
			            label: {
			                normal: {
			                    show: false,
			                    position: 'outside',
			                },
			                emphasis: {
			                    show: false
			                }
			            },
			            /*data:[
			                {
			                	value:18, 
			                	name:'电',
			                	itemStyle: {
				                    normal:{ 
				                    	color:"#01a7eb",
					                    label:{ 
					                       show: true, 
					                       formatter: '{d}%  ({c})' 
					                    }, 
					                    labelLine :{show:true}
					                }
				               	},
			                },
			                {
			                	value:17, 
			                	name:'水',
			                	itemStyle: {
				                    normal: {
				                        color:"#f2901e",
				                    }
				               	},
			                },
			                {
			                	value:15, 
			                	name:'蒸汽',
			                	itemStyle: {
				                    normal: {
				                        color:"#77c06e"
				                    }
				               	},
			                },
			                {
			                	value:14, 
			                	name:'燃料',
			                	itemStyle: {
				                    normal: {
				                        color:"#e94347"
				                    }
				               	},
			                },
			                {
			                	value:20, 
			                	name:'风',
			                	itemStyle: {
				                    normal: {
				                        color:"#7179cb"
				                    }
				               	},
			                },
			            ],*/
			           	data: nyxhDataArray,
			            icon:'scatter',
			            itemStyle:{ 
			                normal:{ 
			                    label:{ 
			                       show: true, 
			                       formatter: '{d}%\n({c})' 
			                    }, 
			                    labelLine :{show:true}
			                } 
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
			            		length:16,
			            		lineStyle:{
			            			color: '#cac9ce',
			            			type: 'solid',
			            		}
			            	}
			            	
			            },
			        },
			    ]
			};
			
			myChartMg.setOption(MgOption);
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    /*console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)*/
			
		}
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
  	
  	var myChartJl = echarts.init(document.getElementById('main_jl'));
  	var jlOption = {
	    tooltip : {
	    	show:false,
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
	            data : ['水','电','蒸汽','风','燃料'],
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
                    margin: 15,
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
	            name:'个        ',
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
	            barWidth: '32%',
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
	            data:[7, 10, 16, 14, 19]
	        },
	        {
	            name:'虚表',
	            type:'bar',
	            stack: 'gg',
	            label: {
					normal: {
						show: true,
						position: [7, 2],
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
	            data:[5, 4, 3, 7, 8]
	        },
	        {
	            name:'hh',
	            type:'bar',
	            stack: 'gg',
	            zlevel:3,
	            data:[10, 52, 10, 13, 90, 13, 12],
	            itemStyle: {
                    normal: {
                        color:'rgba(0,0,0,0)',
                        //柱形图顶部显示数值
                        label : {show: true, position: 'bottom'}
                    }
               	},
               	label: {
	
	                normal: {
	                    offset:['50', '80'],
	                    show: true,
	                    position: 'insideBottom',
	                    formatter:'{c}%',
	                    textStyle:{
	                        color:'#000'
	                    }
	                }
	            },
	        },
	    ]
	};
  	jlOption.yAxis[0].max = 30;
  	myChartJl.setOption(jlOption);
  	
  	
  	
  	
})
		

	
  	
  	
  	
  	
  	//加载
  	/*myChart.showLoading({
  		text: "图表数据正在努力加载...",
  	})
  	myChart.hideLoading();*/
  	// 基于准备好的dom，初始化echarts实例
	$(".seeCH_Detail").click(function(){
		window.location.href = "chanHaoFXDepartment.html?areaId=&FactoryData=";
	})
	
	$(".seeCB_Detail").click(function(){
		window.location.href = "dongLiZaiXianYHz.html?areaId=&FactoryData=";
	})
	
	$(".seeZB_Detail").click(function(){
		window.location.href = "nengyuanZBdetails.html?areaId=&FactoryData=";
	})
	
	$(".seeJL_Detail").click(function(){
		window.location.href = "jiLiangFXDepartment.html?areaId=&FactoryData=";
	})
