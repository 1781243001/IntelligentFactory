
$(function(){
	/*setTimeout(function(){
		$("body").css({"display":"block"})
	},1600)*/
	var baseObj = new Base();
    var domainStr = baseObj.mainDomain;
    var loading = new Loading()

    loading.show()
    var DepartmentAll = baseObj.getQuery(window.location.search, 'sjson');
	//var DepartmentAll = '[{"id":"5466","text":"化工部东区","orderId":0,"selected":1},{"id":"5461","text":"化工部西区","orderId":0,"selected":1}]'
	/*var P = '<p>'+DepartmentAll+'</p><p>第三方斯蒂芬</p>';
	$("body").append(P)*/
	
	if(DepartmentAll == ""){
		//bm_mrAreaListData()
	} else {
		localStorage.setItem("Department",DepartmentAll);
		var Department = JSON.parse(localStorage.getItem("Department"));
		console.log(Department)
		bm_dzAreaListData(Department)
	}
    
    $(".company_name p").on("click",function(){
		console.log($(this).text())
		
		if($(this).hasClass("dz")){
			$(this).removeClass("dz").siblings().addClass("dz")
		}
		if($(this).text() == "切换到定制"){
			$(".chmrListBody").css({"display":'none'}).siblings().css({"display":'block'})
			console.log("这是定制页面")
			$(".bodyall").css({"padding-bottom":".88rem"})
			$(".footer").css({"display":'block'})
			//var Department = JSON.parse(localStorage.getItem("Department")) || [];
			console.log(Department)
			//bm_dzAreaListData(Department)
		} else if($(this).text() == "切换到默认"){
			//bm_mrAreaListData()
			$(".bodyall").css({"padding-bottom":"0"})
			$(".chdzListBody").css({"display":'none'}).siblings().css({"display":'block'})
			$(".footer").css({"display":'none'})
		}
		
	})
    
    
    
	steam()
	function steam(){
		var chart = echarts.init(document.getElementById('cy_main_1'));
		var optionLine = {
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
						res+=params[i].marker+'<span>'+params[i].seriesName+':'+params[i].data+'</span></br>';
					}
					return res;
				},
				//extraCssText: 'box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);',
		    },
		    grid: {  
		    	show: false,
		    	top:'10%',
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
		        data:['邮件营销','联盟广告'],
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
		            data : ['5/29','5/30','5/31','6/1','6/2','6/3','6/4','6/5','6/6','6/7','6/8','6/9','6/10','6/11','6/12','6/19','6/26'],
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
		    		show:false,
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
	                    show: false,
	                    textStyle: {
	                        color: '#89898e'
	                    },
	                    formatter: '{value}'
	               },
	               
	               //坐标轴分割线
	               splitLine : {
	               		show:false,
	               		lineStyle:{
	               			color: ['#eee'],
	               		}
	               		
	               },
	               axisTick:{ show:false },//去掉小横/竖杠
		    	}
		    ],
		    series : [
		        {
		            name:'不平衡量',
		            type:'line',
		            stack: '分分',
		            data:[6, 9, 16, 5, 8,6, 9, 16, 5, 8,6, 9, 10, 5, 8,6, 9, 6, 5, 8,6, 9, 6, 5, 8,6, 9, 16, 5, 8,],
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
	}
	
	
	
	
	
	
    var strJson = {
            AppID: "zb.s20170704000000001",
            DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
            EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
            EquipType: "iPhone",
            IsEncrypted: 'false',
            UserID: "test",
            RequestMethod: "e9356e20-c203-496f-b637-3eed075349fa|9e7f8445-9094-4640-adc9-4a5cda4b6876",//"54e36de2-18c2-43f4-ae7c-28348c141059|41a36aa1-d997-4ab2-894c-7eefad6e7f91",
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
	   		var chaYiFXData = JSON.parse(msg).mediumList[0].children;
	   		var chaYiFXNavData = '';
	   		$.each(chaYiFXData, function(i) {
	   			chaYiFXNavData += '<li>'+
									'<div class="sel_box clear">'+
										'<p class="active_label">'+chaYiFXData[i].text+'</p>'+      
									'</div>'+
								'</li>';
	   		});
	   		$(".cy_navbox").append(chaYiFXNavData)
	   		
	   		$(".cy_navbox li").on("click",function(){
				$(this).addClass("cy_navbox_active").siblings().removeClass("cy_navbox_active");
			})
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			//loading.hide();
            //loading.alertMsg('获取问题类型失败！');
		}
	});
	
	$(".footer").on("click",function(){
		alert("dingZHiGuanWangTiaoZhuan")
		window.location.href = "dingZHiGuanWangTiaoZhuan";
	})
	
	
	
	
	
	//介质
	var JZParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "e9356e20-c203-496f-b637-3eed075349fa|9e7f8445-9094-4640-adc9-4a5cda4b6876",
        RequestParams: [{"value": "0", "key": "value1"}]
        
  	}
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(JZParam),
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
	
	
	//管网
	var gwParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "e9356e20-c203-496f-b637-3eed075349fa|c732de3a-0c23-4533-904a-e5e1910a9d57",
        RequestParams: [{"value": "0", "key": "value1"}]
        
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
	
	
	

})