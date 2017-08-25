
$(function(){
	/*setTimeout(function(){
		$("body").css({"display":"block"})
	},1600)*/
	var baseObj = new Base();
	var domainStr = baseObj.mainDomain;
	var loading = new Loading()
	var chanHaoDZAll = baseObj.getQuery(window.location.search, 'sjson');
	//var chanHaoDZAll = '[{"id":"5468","text":"化工部东区","orderId":0,"selected":1},{"id":"5461","text":"化工部西区","orderId":0,"selected":1}]'
	/*var P = '<p>'+chanHaoDZAll+'</p><p>第三方斯蒂芬</p>'
	$("body").append(P)*/
	
	if(chanHaoDZAll == ""){
		bm_mrAreaListData()
	} else {
		localStorage.setItem("chanHaoData",chanHaoDZAll);
		var chanHaoData = JSON.parse(localStorage.getItem("chanHaoData"));
		bm_dzAreaListData(chanHaoData)
	}
	
	
	
	
	$(".company_name p").on("click",function(){
		console.log($(this).text())
		
		if($(this).hasClass("dz")){
			$(this).removeClass("dz").siblings().addClass("dz")
		}
		if($(this).text() == "切换到定制"){
			$(".chmrListBody").css({"display":'none'}).siblings().css({"display":'block'})
			$(".chbodyall").css({"padding-bottom":".88rem"})
			console.log("这是定制页面")
			$(".footer").css({"display":'block'})
			var chanHaoData = JSON.parse(localStorage.getItem("chanHaoData")) || [];
			console.log(chanHaoData)
			bm_dzAreaListData(chanHaoData)
		} else if($(this).text() == "切换到默认"){
			bm_mrAreaListData()
			$(".chbodyall").css({"padding-bottom":"0"})
			$(".chdzListBody").css({"display":'none'}).siblings().css({"display":'block'})
			$(".footer").css({"display":'none'})
		}
		
	})
	
	$(".footer").on("click",function(){
		var DepartmentData = "DepartmentData"
		window.location.href = 'chanHaoFXDepartment.html?DepartmentData='+DepartmentData;
	})
	
	
	
	
	jzData()
	function jzData(){
		loading.show();
  		var jzJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"696969f2-bc52-4fec-bf9f-9859d528a750|12425b7a-01e0-4c8c-9e1c-98de7e3b17e9",
			"RequestParams": [{ "value": "0", "key": "value1" }]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(jzJson),
	        success: function(msg){
	        	console.log(JSON.parse(msg))
	        	var jzData = JSON.parse(msg).mediumList[0].children;
	        	console.log(jzData)
	        	var jzDome = "";
	        	$.each(jzData, function(i) {
	        		jzDome += '<li>'+jzData[i].text+'</li>'
	        	});
	        	$(".cy_navbox").append(jzDome);
	        	$(".cy_navbox li:first-child").addClass("cyavtive");
	        	//console.log($(".cy_navbox li:first-child"))
	        	$(".cy_navbox li").on("click",function(){
	        		$(this).addClass("cyavtive").siblings().removeClass("cyavtive")
	        	})
	        	
	        	
	        	
	        	loading.hide();
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
	        
		})
  	}
	
	function bm_dzAreaListData(chanHaoData){
		$(".chdzListBody").empty();
		$(".chdzListBody").css({"display":"block"}).siblings().css({"display":"none"});
		$(".footer").css({"display":"block"});
		var P = $(".company_name>p");
		$.each(P, function(i) {
			if($(this).hasClass("dz")){
				$(this).removeClass("dz").siblings().addClass("dz")
			}
		});
    	var listDome = "";
    	$.each(chanHaoData, function(i) {
    		listDome += '<section class="outBox" style="margin-top: 0px;">'+
							'<div class="title clear">'+
								'<div data-areaId='+chanHaoData[i].id+' class="left-c areaId">'+decodeURIComponent(decodeURIComponent(chanHaoData[i].text))+'</div>'+
							'</div>'+
							'<div id="ch_index_'+chanHaoData[i].id+'" class="chfx_cbox_dz"></div>'+
						'</section>';
    	});
    	$(".chdzListBody").append(listDome);
    	loading.hide();
    	
    	$.each($(".chfx_cbox_dz"), function() {
			var myChart = echarts.init(document.getElementById($(this).attr("ID")));
			var optionBar = $(this).attr("ID");
			optionBar = {
				grid: {  
				    left: '2%',  
				    right: '8%',  
				    bottom: '-46%', 
				    top:'0%',
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
			    yAxis : [
			        {	
			        	show: true,
			        	boundaryGap: [0, 0.1],
			        	data:["出向", "进向"],
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
			        	show : false,
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
			            barWidth : '20',
						barCategoryGap: 200,
			            data:[50,60],
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
		                        color: function(params) {
			                        // build a color map as your need.
			                        var colorList = [
			                          '#f08200','#00a1eb'
			                        ];
			                        return colorList[params.dataIndex]
			                    },
		                    }
		                    
		              	},
			           	barGap:'20'
			        },
			        {
			            name:'外购',
			            type:'bar',
			            stack: 'sum',
			            data:[50,60],
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
		                        color: function(params) {
			                        // build a color map as your need.
			                        var colorList = [
			                          '#fcaa56','#00baef'
			                        ];
			                        return colorList[params.dataIndex]
			                    },
		                    },
		               	},
			           	barGap:'20%'
			        },
			        {
			            name:'供入',
			            type:'bar',
			            stack: 'sum',
			            data:[40,50],
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
		                        color: function(params) {
			                        // build a color map as your need.
			                        var colorList = [
			                          '#fdcea2','#89def5'
			                        ];
			                        return colorList[params.dataIndex]
			                    },
		                    },
		               	},
			           	barGap:'20%'
			        },
			        {
			            name: '总和',
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
		        	},  
			    ]
			};
			
			myChart.setOption(optionBar);
		});
    	
    	$(".seeCh_Detail").on("click",function(){
    		var areaId = $(this).attr("data-areaId");
    		var  areaName = encodeURIComponent(encodeURIComponent($(this).siblings().text()));
    		console.log(areaName)
			var sJson = [0,2,4,6,8,10];
    		window.location.href = "chanHaoFXzhz.html?areaId="+areaId+"&areaName="+areaName;

    	})
    	
    	$(".areaId").on("click",function(){
    		var areaId = $(this).attr("data-areaId");
    		window.location.href = "chaoHaoFXdetail.html?areaId="+areaId+"&FactoryData=";

    	})
	}
	
	function bm_mrAreaListData(){
		loading.show();
  		var ereaJson = {
			"AppID":"zb.s20170704000000001",
			"DeviceID":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipSN":"92203450-4267-4AA1-93DB-45CE7C2097DE",
			"EquipType":"iPhone",
			"IsEncrypted":"false",
			"UserID":"test",
			"RequestMethod":"696969f2-bc52-4fec-bf9f-9859d528a750|b704e211-4a94-4d49-8bac-3acf550351f1",
			"RequestParams": [{ "value": "0", "key": "value1" }]
		}
		$.ajax({
			type: "post",
	        async: true,
	        url: "http://10.246.109.109/app/api/MobileBusiness/GetPageViewData",//"http://localhost:11979/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(ereaJson),
	        success: function(msg){
        		$(".chmrListBody").empty();
        		console.log(JSON.parse(msg))
	        	var listData = [{"id":"5461","text":"炼油部联合一车间","orderId":0,"selected":1},{"id":"5462","text":"炼油部联合二车间","orderId":0,"selected":1},{"id":"5463","text":"炼油部联合三车间","orderId":0,"selected":1},{"id":"5464","text":"炼油部联合四车间","orderId":0,"selected":1}]
	        	console.log(listData)
	        	var listDome = "";
	        	$.each(listData, function(i) {
	        		listDome += '<section class="outBox" style="margin-top: 0px;">'+
									'<div class="title clear">'+
										'<div data-areaId='+listData[i].id+' class="left-c areaId">'+listData[i].text+'</div>'+
										'<div data-areaId='+listData[i].id+' class="seeCh_Detail">车间列表</div>'+
									'</div>'+
									'<div id="ch_index_'+listData[i].id+'" class="chfx_cbox_mr"></div>'+
								'</section>';
	        	});
	        	$(".chmrListBody").append(listDome);
	        	$(".seeCh_Detail").on("click",function(){
	        		var areaId = $(this).attr("data-areaId");
	        		var  areaName = encodeURIComponent(encodeURIComponent($(this).siblings().text()));
	        		window.location.href = "chanHaoFXzhz.html?areaId="+areaId+"&areaName="+areaName+"&FactoryData=";
	        	})
	        	
	        	$(".areaId").on("click",function(){
	        		var areaId = $(this).attr("data-areaId");
	        		//var  areaName = encodeURIComponent(encodeURIComponent($(this).siblings().text()));
	        		//console.log(areaName)
	
	        		window.location.href = "chaoHaoFXdetail.html?areaId="+areaId+"&FactoryData=";

	        	})

				loading.hide();
				
	        	$.each($(".chfx_cbox_mr"), function() {
	        		echarts.dispose(document.getElementById($(this).attr("ID")));
					var myChart = echarts.init(document.getElementById($(this).attr("ID")));
					var optionBar = $(this).attr("ID");
					optionBar = {
						grid: {  
						    left: '2%',  
						    right: '8%',  
						    bottom: '-46%', 
						    top:'0%',
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
					    yAxis : [
					        {	
					        	show: true,
					        	boundaryGap: [0, 0.1],
					        	data:["出向", "进向"],
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
					        	show : false,
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
					            barWidth : '20',
								barCategoryGap: 200,
					            data:[50,60],
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
				                        color: function(params) {
					                        // build a color map as your need.
					                        var colorList = [
					                          '#f08200','#00a1eb'
					                        ];
					                        return colorList[params.dataIndex]
					                    },
				                    }
				                    
				              	},
					           	barGap:'20'
					        },
					        {
					            name:'外购',
					            type:'bar',
					            stack: 'sum',
					            data:[50,60],
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
				                        color: function(params) {
					                        // build a color map as your need.
					                        var colorList = [
					                          '#fcaa56','#00baef'
					                        ];
					                        return colorList[params.dataIndex]
					                    },
				                    },
				               	},
					           	barGap:'20%'
					        },
					        {
					            name:'供入',
					            type:'bar',
					            stack: 'sum',
					            data:[40,50],
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
				                        color: function(params) {
					                        // build a color map as your need.
					                        var colorList = [
					                          '#fdcea2','#89def5'
					                        ];
					                        return colorList[params.dataIndex]
					                    },
				                    },
				               	},
					           	barGap:'20%'
					        },
					        {
					            name: '总和',
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
				        	},  
					    ]
					};
					
					myChart.setOption(optionBar);
				});
			},
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    /*console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)*/
				
			}
	        
		})
  	};
	
	$(".subcy_navbox li").on("click",function(){
		$(this).addClass("subcy_navbox_active").siblings().removeClass('subcy_navbox_active')
	})
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*var testArray = [0,1,2,3,4,5,6,7,8,9];
	var echartsContent = "";
	$.each(testArray, function(i) {
		echartsContent += '<section class="outBox" style="margin-top: 0px;">'+
				'<div class="title clear">'+
					'<div class="left-c">燕山石化</div>'+
				'</div>'+
				'<div id="ch_index_'+i+'" class="chfx_cbox"></div>'+
			'</section>';
			console.log(i)
			
			
	});
	
	$(".chfx_box").append(echartsContent)
	
	
	$.each($(".chfx_cbox"), function() {
		var myChart = echarts.init(document.getElementById($(this).attr("ID")));
		var optionBar = $(this).attr("ID");
		optionBar = {
			grid: {  
			    left: '2%',  
			    right: '8%',  
			    bottom: '-46%', 
			    top:'0%',
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
		    yAxis : [
		        {	
		        	show: true,
		        	boundaryGap: [0, 0.1],
		        	data:["出向", "进向"],
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
		        	show : false,
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
		            barWidth : '20',
					barCategoryGap: 200,
		            data:[50,60],
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
	                        color: function(params) {
		                        // build a color map as your need.
		                        var colorList = [
		                          '#f08200','#00a1eb'
		                        ];
		                        return colorList[params.dataIndex]
		                    },
	                    }
	                    
	              	},
		           	barGap:'20'
		        },
		        {
		            name:'外购',
		            type:'bar',
		            stack: 'sum',
		            data:[50,60],
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
	                        color: function(params) {
		                        // build a color map as your need.
		                        var colorList = [
		                          '#fcaa56','#00baef'
		                        ];
		                        return colorList[params.dataIndex]
		                    },
	                    },
	               	},
		           	barGap:'20%'
		        },
		        {
		            name:'供入',
		            type:'bar',
		            stack: 'sum',
		            data:[40,50],
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
	                        color: function(params) {
		                        // build a color map as your need.
		                        var colorList = [
		                          '#fdcea2','#89def5'
		                        ];
		                        return colorList[params.dataIndex]
		                    },
	                    },
	               	},
		           	barGap:'20%'
		        },
		        {
		            name: '总和',
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
	        	},  
		    ]
		};
		
		myChart.setOption(optionBar);
	});*/
})