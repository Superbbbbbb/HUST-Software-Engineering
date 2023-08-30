var pageSize=0;//每页显示行数
var currentPage_=1;//当前页全局变量，用于跳转时判断是否在相同页，在就不跳，否则跳转。
var totalPage;//总页数
var totalTr;//总行数

//跳转页面
function goPage(pno,psize){

    var itable = document.getElementById("listbody");
    var num = itable.rows.length;//表格所有行数(所有记录数)
    totalTr = num;
    //alert(num);

    pageSize = psize;//每页显示行数
    //总共分几页 
    if(num/pageSize > parseInt(num/pageSize)){
        totalPage=parseInt(num/pageSize)+1;
    }else{
        totalPage=parseInt(num/pageSize);
    }
    var currentPage = pno;//当前页数
    currentPage_=currentPage;
    var startRow = (currentPage - 1) * pageSize+1;
    var endRow = currentPage * pageSize;
    endRow = (endRow > num)? num : endRow;
    //遍历显示数据实现分页

    $("#listbody tr").hide();
    for(var i=startRow-1;i<endRow;i++)
    {
        $("#listbody tr").eq(i).show();
    }

    document.getElementById("total_tr").innerHTML = "共"+num+"条";
    document.getElementById("paging").value = "10条/页";
    document.getElementById("total_page").innerHTML = "共"+totalPage+"页";

    if(currentPage>1){
        $("#firstPage").on("click",function(){
            goPage(1,psize);
        }).removeClass("ban");
        $("#prePage").on("click",function(){
            goPage(currentPage-1,psize);
        }).removeClass("ban");
    }else{
        $("#firstPage").off("click").addClass("ban");
        $("#prePage").off("click").addClass("ban");
    }

    if(currentPage<totalPage){
        $("#nextPage").on("click",function(){
            goPage(currentPage+1,psize);
        }).removeClass("ban")
        $("#lastPage").on("click",function(){
            goPage(totalPage,psize);
        }).removeClass("ban")
    }else{
        $("#nextPage").off("click").addClass("ban");
        $("#lastPage").off("click").addClass("ban");
    }

    $("#input_page").val(currentPage);
}

// 获取信息
function get_info()
{
    $('#table1 tbody').html('');

    goPage(1,10);
}

