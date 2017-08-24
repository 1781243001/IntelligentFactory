
$(function(){
	/*setTimeout(function(){
		$("body").css({"display":"block"})
	},1600)*/
	var baseObj = new Base();
	var domainStr = baseObj.mainDomain;
	var loading = new Loading()
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
	console.log(changeData)
	var jlEareParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "12b33b17-64a6-4961-8cd7-d8e3105cb603|c97b778f-fafd-46a6-b1c2-f6cd98e2bd97",
        RequestParams: [{"value": "0", "key": "value1"}]
        
  	}
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(jlEareParam),
	   	success: function(msg){
	   		console.log(JSON.parse(msg))
	   		var areaName = JSON.parse(msg).treeList[0].children;
	   		console.log(areaName)
	   		var oneDome = "";
	   		$.each(areaName, function(i) {
	   			oneDome += '<li data-areaId='+areaName[i].id+'>'+areaName[i].text+'</li>'
	   		});
   			$(".navliboxone").append(oneDome)
	   		$(".navliboxone li:first-child").addClass("cyavtive");
	   		$(".navliboxone li:first-child").attr("data-areaId");
	   		getKPIData($(".navliboxone li:first-child").attr("data-areaId"),changeData)
	   		
	   		$(".navliboxone li").on("click",function(){
	   			$(this).addClass("cyavtive").siblings().removeClass("cyavtive")
	   			var areaId = $(this).attr("data-areaId");
	   			console.log(typeof areaId)
	   			//QXData(areaId)
	 			getKPIData(areaId,changeData)
	   			console.log(areaId)
	   			$.each(areaName, function(i) {
	   				if(areaName[i].id == areaId){
	   				    var twoData = areaName[i].children;
	   					var twoDome = '';
	   					$.each(twoData, function(i) {
	   						twoDome += '<li data-twoAreaId='+twoData[i].id+'>'+twoData[i].text+'</li>';
	   					});
	   					$(this).addClass("cyavtive").siblings().removeClass("cyavtive")
	   					$(".navliboxtwo").empty()
	   					$(".navliboxtwo").css({"display":"block"});
	   					$(".navliboxthree").css({"display":"none"});
	   					$(".navliboxfour").css({"display":"none"});
	   					$(".navliboxtwo").append(twoDome)
	   					
	   					
	   					$(".navliboxtwo li").on("click",function(){
				   			$(this).addClass("cyavtive").siblings().removeClass("cyavtive")
				   			var areaId = $(this).attr("data-twoAreaId");
				   			//QXData(areaId)
	 						getKPIData(areaId,changeData)
				   			console.log(areaId)
				   			$.each(twoData, function(i) {
				   				if(twoData[i].id == areaId){
				   					console.log(twoData[i].children)
				   				    var threeData = twoData[i].children;
				   					var threeDome = '';
				   					$.each(threeData, function(i) {
				   						threeDome += '<li data-threeAreaId='+threeData[i].id+'>'+threeData[i].text+'</li>';
				   					});
				   					$(this).addClass("cyavtive").siblings().removeClass("cyavtive")
				   					$(".navliboxthree").empty()
				   					$(".navliboxthree").css({"display":"block"});
				   					$(".navliboxthree").append(threeDome)
				   					
				   					$(".navliboxthree li").on("click",function(){
							   			$(this).addClass("cyavtive").siblings().removeClass("cyavtive")
							   			var areaId = $(this).attr("data-threeAreaId");
							   			//QXData(areaId)
	 									getKPIData(areaId,changeData)
							   			//console.log(areaId)
							   			//console.log(threeData)
							   			$.each(threeData, function(i) {
							   				if(threeData[i].id == areaId){
							   					//console.log(threeData[i].children)
							   				    var fourData = threeData[i].children;
							   				    if(fourData.length != 0){
							   				    	//console.log(111111111)
							   				    	var fourDome = '';
								   					$.each(fourData, function(i) {
								   						fourDome += '<li data-fourAreaId='+fourData[i].id+'>'+fourData[i].text+'</li>';
								   					});
								   					$(this).addClass("cyavtive").siblings().removeClass("cyavtive")
								   					$(".navliboxfour").empty()
								   					$(".navliboxfour").css({"display":"block"});
								   					$(".navliboxfour").append(fourDome)
								   					
								   					$(".navliboxfour li").on("click",function(){
								   						$(this).addClass("cyavtive").siblings().removeClass("cyavtive")
								   						var areaId = $(this).attr("data-fourAreaId");
								   						//QXData(areaId)
														getKPIData(areaId,changeData)
								   						console.log(areaId)
								   					})
							   				    } else {
							   				    	return
							   				    }
							   					
							   				}
							   			});
							   		})
				   				}
				   			});
				   		})
	   				}
	   			});
	   		})	
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)
			
		}
	});
	
	
	/*$(".nyl_nav").unbind('click').bind("click",function(){
		$(".mylayer").css({"display":"block"});
		$(".myshowcontent").unbind('click').bind("click",function(event){
			event.stopPropagation();
			console.log($(this).attr("data-kpiId"))
			$(this).addClass("bk").siblings().removeClass("bk")
			$(".mylayer").css({"display":"none"});
		})
	})*/
	
	
	
	
	
	
	
	
	
	
	
	
	/*loading.show()
	loading.hide()*/
	//loading.alertMsg('sdfsdfds')
	
	
	//var chart = echarts.init(document.getElementById('nyPie'));
	/*var nyPieOption = {
	    tooltip: {
	        trigger: 'item',
	        formatter: "{a} <br/>{b}: {c} ({d}%)"
	    },
	    legend: {
	    	show: false,
	        orient: 'vertical',
	        x: 'left',
	        data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
	    },
	    series: [
	        {
	            name:'访问来源',
	            type:'pie',
	            radius: ['50%', '70%'],
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
	            data:[
	                {value:335, name:'直接访问'},
	                {value:310, name:'邮件营销'},
	                {value:234, name:'联盟广告'},
	                {value:135, name:'视频广告'},
	                {value:1548, name:'搜索引擎'}
	            ]
	        }
	    ]
	};
	
	chart.setOption(nyPieOption);*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//第一介质
	function jzTData(xtName,ysltDataArray,qrltDataArray,phltDataArray,phqrltDataArray,dbsxtDataArray,dbxxtDataArray,cpyytDataArray){
		console.log(phltDataArray)
		console.log(qrltDataArray)
		echarts.dispose(document.getElementById('main_1'));
		var chart = echarts.init(document.getElementById('main_1'));
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
			    left: '3%',  
			    right: '0%',  
			    bottom: '20%',  
			    containLabel: true ,
			    borderColor:'#fff',
			    shadowBlur :100,
			    shadowColor: 'red',
		        shadowOffsetX: 50,
		        shadowOffsetY: 80
			},
		    legend: {
		    	show: true,
		        data:['原始量','确认量','平衡量','平衡确认量','产品量或原油加工量'],
		        itemWidth: 20,
		        itemHeight: 8,
		        textStyle: {
					fontSize: 12,
				},
				//padding: 5,
				bottom: '0%',
				itemGap:6,
				/*formatter: function (name) {
				    //return 'Legend ' + name;
				    if(name == "达标上限" || name == "达标下限"){
				    	
				    } else {
				    	 console.log(name)
				    	return name;
				    }
				   
				}*/
				
				//padding: 20,
		        
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
		            data : xtName,//['5月29日','5月30日','5月31日','6月1日','6月2日','6月3日','6月4日','6月5日','6月6日','6月7日','6月8日','6月9日','6月10日','6月11日','6月12日','6月19日','6月26日'],
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
	                    margin: 15,
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
		    		name:'千克标油/吨',
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
		            name:'原始量',
		            type:'line',
		            stack: '原始量',
		            data:ysltDataArray,//[20, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
		            itemStyle: {
	                    normal: {
	                        color:"#1ec7ca",
	                    }
	               	},
	               	/*markLine: {
		        		silent: true,
		        		type:'line',
						data: [{
				                    yAxis: 20,
				                    value: '达标线',
				               },
								{
				                    yAxis: 5,
				                    value: '达标线',
				                }],
				        symbolSize:[0,0]
						
		        	}*/
		        },
		        {
		            name:'确认量',
		            type:'line',
		            stack: '确认量',
		            data:qrltDataArray,//[6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
		            itemStyle: {
	                    normal: {
	                        color:"#a37bf2",
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
		        {
		            name:'平衡量',
		            type:'line',
		            stack: '平衡量',
		            data:phltDataArray,//[9, 16, 5, 8,6, 9, 16, 15, 8,6, 9, 16, 5, 8,6, 9, 6, 5, 8,16, 9, 6, 5, 8,6, 9, 16, 15, 8,6,],
		            itemStyle: {
	                    normal: {
	                        color:"#008fff",
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
		       	{
		            name:'平衡确认量',
		            type:'line',
		            stack: '平衡确认量',
		            data:phqrltDataArray,//[17, 23, 16, 19,20, 17, 23, 20, 17, 23, 6, 9,6, 17, 23, 16, 19,20, 16, 19,14, 17, 23, 16, 19],
		            symbolSize:4,
		            //symbolOffset:[6,6],
		            itemStyle: {
	                    normal: {
	                        color:"#f3b276"
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
		            name:'达标上限',
		            type:'line',
		            stack: '达标上限',
		            data:dbsxtDataArray,//[17, 23, 16, 19,20, 17, 23, 20, 17, 23, 6, 9,6, 17, 23, 16, 19,20, 16, 19,14, 17, 23, 16, 19],
		            symbolSize:4,
		            //symbolOffset:[6,6],
		            itemStyle: {
	                    normal: {
	                        color:"#d0011b"
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
		            name:'达标下限',
		            type:'line',
		            stack: '达标下限',
		            data:dbxxtDataArray,//[17, 23, 16, 19,20, 17, 23, 20, 17, 23, 6, 9,6, 17, 23, 16, 19,20, 16, 19,14, 17, 23, 16, 19],
		            symbolSize:4,
		            //symbolOffset:[6,6],
		            itemStyle: {
	                    normal: {
	                        color:"#d0011b"
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
		            name:'产品量或原油加工量',
		            type:'line',
		            stack: '达标下限',
		            data:cpyytDataArray,//[17, 23, 16, 19,20, 17, 23, 20, 17, 23, 6, 9,6, 17, 23, 16, 19,20, 16, 19,14, 17, 23, 16, 19],
		            symbolSize:4,
		            //symbolOffset:[6,6],
		            itemStyle: {
	                    normal: {
	                        color:"#005BAC"
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
		    ]
		};
		
		chart.setOption(optionLine);
	}
	
	
	
	
	//曲线图
	//QXData("19003","10351")
	function QXData(areaId,kpiId,changeData){
		var dlqustParam = {
	        AppID: "zb.s20170704000000001",
	        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipType: "iPhone",
	        IsEncrypted: 'false',
	        UserID: "test",
	        RequestMethod: "12b33b17-64a6-4961-8cd7-d8e3105cb603|02ca6f9d-cb0f-401f-b7a0-4ecb0ff36d63",
	        RequestParams: [{"value":areaId,"key":" AreaId "},,{"value":kpiId,"key":" Condition1"},{"value":"1","key":" DateType"},{"value":changeData,"key":" DateTime"}]
	   	}
		console.log(dlqustParam)
		$.ajax({
		   	type: "post",
	        async: true,
	        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(dlqustParam),
		   	success: function(msg){
		   		//console.log(JSON.parse(msg))
		   		var jzDataAll = JSON.parse(msg).complexIdxList
		   		console.log(jzDataAll)
		   		var yslDataArray = new Array();//原始量
		   		var qrlDataArray = new Array();//确认量
		   		var phqrlDataArray = new Array();//平衡确认量
		   		var phlDataArray = new Array();//平衡量
		   		var cpyyDataArray = new Array();//产品产量或原油加工量
		   		var dbsxDataArray = new Array();//达标上限
		   		var dbxxDataArray = new Array();//达标下限
		   		var xName =  new Array();//x轴数据
		   		$.each(jzDataAll, function(i) {
		   			/*console.log(i)
		   			if(i == 0){
		   				 console.log()
		   			} else {
		   				
		   			}*/
		   			if(jzDataAll[i].name == "原始量"){
		   				var yslData = jzDataAll[i].data;
		   				$.each(yslData, function(j) {
		   					yslDataArray.push(yslData[j].y)
		   					xName.push(yslData[j].name)
		   				});
		   			};
		   			if(jzDataAll[i].name == "确认量"){
		   				
		   				var qrlData = jzDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(qrlData, function(j) {
		   					yslDataArray.push(qrlData[j].y)
		   				});
		   				//console.log(yslDataArray)
		   			};
		   			if(jzDataAll[i].name == "平衡量"){
		   				
		   				var phlData = jzDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(phlDataArray, function(j) {
		   					phlDataArray.push(phlDataArray[j].y)
		   				});
		   				//console.log(phlDataArray)
		   			};
		   			if(jzDataAll[i].name == "平衡确认量"){
		   				
		   				var phqrlData = jzDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(phqrlData, function(j) {
		   					phqrlDataArray.push(phqrlData[j].y)
		   				});
		   				//console.log(phqrlDataArray)
		   			};
		   			if(jzDataAll[i].name == "达标值上限"){
		   				
		   				var dbsxData = jzDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(dbsxData, function(j) {
		   					dbsxDataArray.push(dbsxData[j].y)
		   				});
		   				//console.log(dbsxDataArray)
		   			};
		   			if(jzDataAll[i].name == "达标值下限"){
		   				
		   				var dbxxData = jzDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(dbxxData, function(j) {
		   					dbxxDataArray.push(dbxxData[j].y)
		   				});
		   				//console.log(dbsxDataArray)
		   			}
		   			if(jzDataAll[i].name == "产品产量或原油加工量"){
		   				
		   				var cpyyData = jzDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(cpyyData, function(j) {
		   					cpyyDataArray.push(cpyyData[j].y)
		   				});
		   				//console.log(cpyyDataArray)
		   			}
		   		});
		   		//console.log(dbxxDataArray)
		   		jzLine(xName,yslDataArray,qrlDataArray,phlDataArray,phqrlDataArray,dbsxDataArray,dbxxDataArray,cpyyDataArray)
		   	},
		   	error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)
				
			}
		});
	}
	
	
	function topQXData(areaId,fistrKpiId,changeData){
		var dlqustParam = {
	        AppID: "zb.s20170704000000001",
	        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipType: "iPhone",
	        IsEncrypted: 'false',
	        UserID: "test",
	        RequestMethod: "12b33b17-64a6-4961-8cd7-d8e3105cb603|02ca6f9d-cb0f-401f-b7a0-4ecb0ff36d63",
	        RequestParams: [{"value":areaId,"key":" AreaId "},,{"value":fistrKpiId,"key":" Condition1"},{"value":"1","key":" DateType"},{"value":changeData,"key":" DateTime"}]
	   	}
		console.log(dlqustParam)
		$.ajax({
		   	type: "post",
	        async: true,
	        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(dlqustParam),
		   	success: function(msg){
		   		//console.log(JSON.parse(msg))
		   		var jztDataAll = JSON.parse(msg).complexIdxList
		   		console.log(jztDataAll)
		   		var ysltDataArray = new Array();//原始量
		   		var qrltDataArray = new Array();//确认量
		   		var phqrltDataArray = new Array();//平衡确认量
		   		var phltDataArray = new Array();//平衡量
		   		var cpyytDataArray = new Array();//产品产量或原油加工量
		   		var dbsxtDataArray = new Array();//达标上限
		   		var dbxxtDataArray = new Array();//达标下限
		   		var xtName =  new Array();//x轴数据
		   		$.each(jztDataAll, function(i) {
		   			if(jztDataAll[i].name == "原始量"){
		   				var ysltData = jztDataAll[i].data;
		   				$.each(ysltData, function(j) {
		   					ysltDataArray.push(ysltData[j].y)
		   					xtName.push(ysltData[j].name)
		   				});
		   			};
		   			if(jztDataAll[i].name == "确认量"){
		   				
		   				var qrltData = jztDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(qrltData, function(j) {
		   					qrltDataArray.push(qrltData[j].y)
		   				});
		   				//console.log(yslDataArray)
		   			};
		   			if(jztDataAll[i].name == "平衡量"){
		   				
		   				var phltData = jztDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(phltData, function(j) {
		   					phltDataArray.push(phltData[j].y)
		   				});
		   				//console.log(phlDataArray)
		   			};
		   			if(jztDataAll[i].name == "平衡确认量"){
		   				
		   				var phqrltData = jztDataAll[i].data;
		   				console.log(jztDataAll[i].data)
		   				var listNumber = phqrltData[phqrltData.length-1].y;
		   				$(".showNY p:first-child").empty()
		   				$(".showNY p:first-child").text(listNumber)
		   				console.log(listNumber)
		   				$.each(phqrltData, function(j) {
		   					phqrltDataArray.push(phqrltData[j].y)
		   				});
		   				//console.log(phqrlDataArray)
		   			};
		   			if(jztDataAll[i].name == "达标值上限"){
		   				
		   				var dbsxtData = jztDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(dbsxtData, function(j) {
		   					dbsxtDataArray.push(dbsxtData[j].y)
		   				});
		   				//console.log(dbsxDataArray)
		   			};
		   			if(jztDataAll[i].name == "达标值下限"){
		   				
		   				var dbxxtData = jztDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(dbxxtData, function(j) {
		   					dbxxtDataArray.push(dbxxtData[j].y)
		   				});
		   				//console.log(dbsxDataArray)
		   			}
		   			if(jztDataAll[i].name == "产品产量或原油加工量"){
		   				
		   				var cpyytData = jztDataAll[i].data;
		   				//console.log(jzDataAll[i].data)
		   				$.each(cpyytData, function(j) {
		   					cpyytDataArray.push(cpyytData[j].y)
		   				});
		   				//console.log(cpyyDataArray)
		   			}
		   		});
		   		//console.log(dbxxDataArray)
		   		
		   		jzTData(xtName,ysltDataArray,qrltDataArray,phltDataArray,phqrltDataArray,dbsxtDataArray,dbxxtDataArray,cpyytDataArray)
		   	},
		   	error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)
				
			}
		});
	}
	
	
	//KPI面板
	//getKPIData("19003")
	function getKPIData(areaId,changeData){
		$(".myshow").empty()
		var NYParam = {
	        AppID: "zb.s20170704000000001",
	        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
	        EquipType: "iPhone",
	        IsEncrypted: 'false',
	        UserID: "test",
	        RequestMethod: "12b33b17-64a6-4961-8cd7-d8e3105cb603|5cb1251b-0fd6-46fb-9c78-1acc1d2180a9",
	        RequestParams: [{"value":areaId,"key":" AreaId "},{"value":"1","key":" DateType"},{"value":changeData,"key":" DateTime"}]
	        
	  	}
		//console.log(NYParam)
		$.ajax({
		   	type: "post",
	        async: true,
	        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
	        contentType: "application/x-www-form-urlencoded",
	        data: JSON.stringify(NYParam),
		   	success: function(msg){
		   		console.log(JSON.parse(msg))
		   		var kpiData = JSON.parse(msg).IdxsecBalValList;
		   		var kpiDome = "";
		   		$.each(kpiData, function(i) {
		   			if(i>0){
		   				kpiDome += '<div data-kpiId='+kpiData[i].id+' class="myshowcontent">'+
									'<p>'+kpiData[i].text+'</p>'+
								'</div>';
		   			}
		   		});
		   		$(".myshow").append(kpiDome);
		   		
		   		if($(".myshow") == ""){
		   			console.log(1111111)
		   		}
		   		//console.log($(".myshow:first-child p").text())
		   		$(".nyl_nav").text($(".myshow div:first-child p").text())
		   		if($(".myshow div:nth-of-type(2)").attr("data-kpiId") == undefined || $(".myshow div:nth-of-type(2)").attr("data-kpiId") == ""){
		   			$(".nyHide").css({"display":"none"})
		   		} else {
		   			$(".nyHide").css({"display":"block"})
		   			QXData(areaId,$(".myshow div:nth-of-type(2)").attr("data-kpiId"),changeData);
		   		}
		   		console.log(kpiData[0].id)
		   		topQXData(areaId,kpiData[0].id,changeData)
		   		
		   		//debugger
		   		console.log(changeData)
		   		/*console.log(areaId)
		   		console.log($(".myshow div:nth-of-type(2)").attr("data-kpiId"))
		   		console.log($(".myshow div:first-child"))*/
		   		$(".nyl_nav").unbind('click').bind("click",function(){
					$(".mylayer").css({"display":"block"});
					$(".mylayer").unbind('click').bind("click",function(){
						$(this).css({"display":"none"})
						console.log(1111111111)
					});
					$(".myshowcontent").unbind('click').bind("click",function(event){
						event.stopPropagation();
						$(".nyl_nav").text($(this).find("p").text())
						var kpiId = $(this).attr("data-kpiId");
						console.log(areaId)
						console.log(kpiId)
						console.log(changeData)
						QXData(areaId,kpiId,changeData)
						//QXData("19003","10351")
						$(this).addClass("bk").siblings().removeClass("bk")
						$(".mylayer").css({"display":"none"});
					})
				})
	   			
		   		
		   	},
		   	error: function (XMLHttpRequest, textStatus, errorThrown) {
				console.log("错误")
			    console.log(XMLHttpRequest.responseText)
			    console.log(textStatus)
			    console.log(errorThrown)
				
			}
		});
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//介质消耗关联分析
	function jzLine(xName,yslDataArray,qrlDataArray,phlDataArray,phqrlDataArray,dbsxDataArray,dbxxDataArray,cpyyDataArray){
		echarts.dispose(document.getElementById('main_nyl'));
		var chartJz = echarts.init(document.getElementById('main_nyl'));
		var optionJz = {
		    tooltip : {
		        trigger: 'axis',
		        confine: true,
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
						//console.log(params[i].seriesName)
						//if(params[i].seriesName == "达标上限" || params[i].seriesName == "达标下限"){
							
						//} else {
							//console.log(params[i].seriesName)
							res+=params[i].marker+'<span>'+params[i].seriesName+':'+params[i].data+'</span></br>';
							
						//}
					}
					return res;
				},
		    },
		    grid: {  
		    	show: false,
		    	top:'22%',
			    left: '3%',  
			    right: '0%',  
			    bottom: '20%',  
			    containLabel: true ,
			    borderColor:'#fff',
			    shadowBlur :100,
			    shadowColor: 'red',
		        shadowOffsetX: 50,
		        shadowOffsetY: 80
			},
		    legend: {
		    	show: true,
		        data:['原始量','确认量','平衡量','平衡确认量','产品产量或原油加工量'],
		        itemWidth: 20,
		        itemHeight: 8,
		        textStyle: {
					fontSize: 12,
				},
				//padding: 5,
				bottom: '0%',
				itemGap:6,
				/*formatter: function (name) {
				    //return 'Legend ' + name;
				    if(name == "达标上限" || name == "达标下限"){
				    	
				    } else {
				    	 console.log(name)
				    	return name;
				    }
				   
				}*/
				
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
		    		name:'千克标油/吨',
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
		            name:'原始量',
		            type:'line',
		            stack: '原始量',
		            data:yslDataArray,//[6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
		            itemStyle: {
	                    normal: {
	                        color:"#1ec7ca",
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
		       	{
		            name:'确认量',
		            type:'line',
		            stack: '确认量',
		            data:qrlDataArray,//[6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
		            itemStyle: {
	                    normal: {
	                        color:"#d0011b",
	                    }
	               	},
		       	},
		       	{
		            name:'平衡量',
		            type:'line',
		            stack: '平衡量',
		            data:phlDataArray,//[6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
		            itemStyle: {
	                    normal: {
	                        color:"#008fff",
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
		       	{
		            name:'平衡确认量',
		            type:'line',
		            stack: '平衡确认量',
		            data:phqrlDataArray,//[6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
		            itemStyle: {
	                    normal: {
	                        color:"#f3b276",
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
		       	{
		            name:'达标上限',
		            type:'line',
		            stack: '达标上限',
		            data:dbsxDataArray,//[6, 6, 6, 6,6, 6, 6, 6, 6, 6,6, 6, 6, 6, 6,6, 6, 6, 6, 6, 6, 6, 6, 6, 6,6, 6, 6, 6, 6,],
		            itemStyle: {
	                    normal: {
	                        color:"#d0011b",
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
		       	{
		            name:'达标下限',
		            type:'line',
		            stack: '达标下限',
		            data:dbxxDataArray,//[1, 5, 1, 1,1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1],
		            itemStyle: {
	                    normal: {
	                        color:"#d0011b",
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
		       	{
		            name:'产品产量或原油加工量',
		            type:'line',
		            stack: '产品产量或原油加工量',
		            data:cpyyDataArray,//[6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
		            itemStyle: {
	                    normal: {
	                        color:"#005BAC",
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
		
		chartJz.setOption(optionJz);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
})