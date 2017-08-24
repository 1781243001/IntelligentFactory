
$(function(){
	/*setTimeout(function(){
		$("body").css({"display":"block"})
	},1600)*/
	var baseObj = new Base();
	var domainStr = baseObj.mainDomain;
	var loading = new Loading()
	/*loading.show()
	loading.hide()*/
	//loading.alertMsg('sdfsdfds')
	
	
	var chart = echarts.init(document.getElementById('nyPie'));
	var nyPieOption = {
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
	
	chart.setOption(nyPieOption);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//能源成本优化			
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
		    left: '0%',  
		    right: '7%',  
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
	        data:['原始量','确认量','平衡量','平衡确认量'],
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
	            data : ['5月29日','5月30日','5月31日','6月1日','6月2日','6月3日','6月4日','6月5日','6月6日','6月7日','6月8日','6月9日','6月10日','6月11日','6月12日','6月19日','6月26日'],
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
	    		name:'千克标油',
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
	            data:[20, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
	            itemStyle: {
                    normal: {
                        color:"#1ec7ca",
                    }
               	},
               	markLine: {
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
					
	        	}
	        },
	        {
	            name:'确认量',
	            type:'line',
	            stack: '确认量',
	            data:[6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
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
	            data:[9, 16, 5, 8,6, 9, 16, 15, 8,6, 9, 16, 5, 8,6, 9, 6, 5, 8,16, 9, 6, 5, 8,6, 9, 16, 15, 8,6,],
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
	            data:[17, 23, 16, 19,20, 17, 23, 20, 17, 23, 6, 9,6, 17, 23, 16, 19,20, 16, 19,14, 17, 23, 16, 19],
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
	    ]
	};
	
	chart.setOption(optionLine);
	
	var dlqustParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "34c11e45-4d31-4ad6-b198-b088d27eb0cc|cecd593d-0955-4849-a131-dfeb0f947f29",
        RequestParams: [{ "value": "0", "key": "value1" }]
   }
	console.log(dlqustParam)
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(dlqustParam),
	   	success: function(msg){
	   		console.log(msg)
	   		
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)
			
		}
	});
	
	
	
	var NYParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "12b33b17-64a6-4961-8cd7-d8e3105cb603|5cb1251b-0fd6-46fb-9c78-1acc1d2180a9",
        RequestParams: [{"value":"19003","key":" AreaId "},{"value":"1","key":" DateType"},{"value":"2017-08-01","key":" DateTime"}]
        
   }
	console.log(dlqustParam)
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(NYParam),
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//介质消耗关联分析
	var chartJz = echarts.init(document.getElementById('main_nyl'));
	var optionJz = {
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
	        data:['蒸汽'],
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
	            data : ['5月29日','5月30日','5月31日','6月1日','6月2日','6月3日','6月4日','6月5日','6月6日','6月7日','6月8日','6月9日','6月10日','6月11日','6月12日','6月19日','6月26日'],
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
	            name:'蒸汽',
	            type:'line',
	            stack: '确认量',
	            data:[6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 16, 5, 8,],
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
	        
	    ]
	};
	
	chartJz.setOption(optionJz);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
})