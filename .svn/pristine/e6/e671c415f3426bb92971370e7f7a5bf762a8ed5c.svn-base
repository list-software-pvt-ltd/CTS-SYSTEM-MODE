var session_branch_code;
var session_main_br_yn;
function onLoad_report_clearing_inward()
{
	var session_loginid = document.getElementById("session_loginid").value;
	 session_branch_code = document.getElementById("session_branch_code").value;
	 session_main_br_yn = document.getElementById("session_main_br_yn").value;
	if(session_loginid == "null")
	{		
		alert("Your Session Has Been Expired. Please Login Again.");		
		menuOnClick("login.jsp");
	}
	else
	{
			var url=document.URL;
			var p=url.lastIndexOf('/');
			baseurl=url.substr(0,p+1);
			baseurl=baseurl+"jsp/getAllBranches.jsp";
			cts_ajax_getBranch(baseurl);
	}
}//onLoad_report_clearing_outward
function fetchCycleNo()
{
	var dateVal=document.getElementById("datepicker").value;
	//alert("fetchCycleNo---"+dateVal);
	if(dateVal=="")
	{
		alert('Date Should Not Be Empty');
	}
	else
	{
		//alert("Before dateVal="+dateVal);
		dateVal=dateVal.replaceAll('-', '');
		//alert("after dateVal="+dateVal);
		var url=document.URL;
			var p=url.lastIndexOf('/');
			baseurl=url.substr(0,p+1);
			baseurl=baseurl+"jsp/getAllCycle.jsp?report_date="+dateVal;
			cts_ajax_getCycle(baseurl);
	}
	
}
function cts_ajax_getCycle(baseurl)
{
	if (window.XMLHttpRequest)
	{
		req = new XMLHttpRequest();
		req.onreadystatechange = cts_process2;	
		req.open("GET", baseurl, true);
		req.send(null);
	}
	else if (window.ActiveXObject)
	{
		req = new ActiveXObject("Microsoft.XMLHTTP");
		if (req)
		{
			req.onreadystatechange =  cts_process2;		
			req.open("GET", baseurl, true);
			req.send(null);
		}
	}	
}//end cts_ajax_getBranch

function cts_process2()
{	
	if(req.readyState == 4)
	{//1
		if(req.status == 200)
		{
			var allData=req.responseText;
			var allstr=allData.split("#");
			var opt_cycl=document.getElementById("opt_cycl");
			
			var option_no = document.createElement('option');
			option_no.text='Not Drawn Own Us';//branch Name
			option_no.value='-1';//branch Code
			//opt_cycl.add(option_no,0);
		    		var allBrn="";
				for(i=0;i<allstr.length-1;i++)
				{					
					var option = document.createElement('option');
					var singleBranch=allstr[i].split("!Q!");
					option.text=singleBranch[1];//branch Name
					option.value=singleBranch[1];//branch Code
					allBrn+=singleBranch[1]+",";
					opt_cycl.add(option,0);
				}
				var option_all = document.createElement('option');
				option_all.text='All';//branch Name
				option_all.value='-1';//branch Code
				opt_cycl.add(option_all,-1);
			
		}//2
		else
		{//1
			alert("Problem In Retrieving Data.Please Check The Server Connection.");		
		}//1
	}//1
}//cts_process2
///---------------------------------------------------------------------------------------------
function cts_ajax_getBranch(baseurl)
{
	if (window.XMLHttpRequest)
	{
		req = new XMLHttpRequest();
		req.onreadystatechange = cts_process1;	
		req.open("GET", baseurl, true);
		req.send(null);
	}
	else if (window.ActiveXObject)
	{
		req = new ActiveXObject("Microsoft.XMLHTTP");
		if (req)
		{
			req.onreadystatechange =  cts_process1;		
			req.open("GET", baseurl, true);
			req.send(null);
		}
	}	
}//end cts_ajax_getBranch

function cts_process1()
{	
	if(req.readyState == 4)
	{//1
		if(req.status == 200)
		{
			var allData=req.responseText;
			var allstr=allData.split("#");
			var obj_opt_branch_code=document.getElementById("opt_branch_code");
			
			var option_no = document.createElement('option');
			option_no.text='Not Drawn Own Us';//branch Name
			option_no.value='-1';//branch Code
			obj_opt_branch_code.add(option_no,0);
		    		var allBrn="";
				for(i=0;i<allstr.length-1;i++)
				{					
					var option = document.createElement('option');
					var singleBranch=allstr[i].split("!Q!");
					option.text=singleBranch[1]+"-"+singleBranch[0];//branch Name
					option.value=singleBranch[1];//branch Code
					allBrn+=singleBranch[1]+",";
					obj_opt_branch_code.add(option,0);
				}
				var option_all = document.createElement('option');
				option_all.text='All';//branch Name
				option_all.value='All';//branch Code
				obj_opt_branch_code.add(option_all,0);
				document.getElementById("opt_branch_code").value='All';
				if(session_main_br_yn=='N')
				{
					obj_opt_branch_code.value=session_branch_code;
					$('#opt_branch_code').attr('disabled',true);
				}
		}//2
		else
		{//1
			alert("Problem In Retrieving Data.Please Check The Server Connection.");		
		}//1
	}//1
}//cts_process1
function onClickOfRunReport()
{
	var dateVal=document.getElementById("datepicker").value;
	if(session_main_br_yn=='N')
	{
	$('#opt_branch_code').attr('disabled',false);
	}
	var branch_code=document.getElementById("opt_branch_code").value;
	var exportToexcel=document.getElementById("chkExcel").checked;
	if(dateVal=='dd-mm-yyyy')
	{
		alert('Date Should Not Be Empty');
		document.getElementById("datepicker").focus();
	}
	else if(branch_code=='0')	
	{
		alert('Select Branch');
		document.getElementById("opt_branch_code").focus();	
	}
	else
	{
		if(document.getElementById("chkExcel").checked)
		{
		   document.getElementById("chkExcel").value="true";	
		}
		document.getElementById("waiting").style.display='';
		document.getElementById('formid').action="jsp/report_clearing_inward.jsp";
		document.getElementById('formid').submit();
		document.getElementById("waiting").style.display='none';		
	}
}//onClickOfGetResult()
