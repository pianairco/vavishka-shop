<%@ page import="ir.piana.dev.strutser.dynamic.form.ElementButton" %>
<%@ page import="ir.piana.dev.strutser.dynamic.form.ElementControl" %>
<%@ page import="ir.piana.dev.strutser.dynamic.form.FormDef" %>
<%@ page import="ir.piana.dev.strutser.dynamic.form.FormManager" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="ir.piana.dev.strutser.dynamic.util.FormControlUtils" %>
<%@ page language="java" errorPage="/error.jsp" contentType="text/html;charset=UTF-8" %>
<%@ include file="/taglibs.jsp"%>

<html dir="rtl">
<head>
</head>
<body >

<style rel="stylesheet">
    .button-box {
        background-color: #fffff0;
    }

    .fieldLabelArea {
        vertical-align: top;
        background-color: #fffff0;
    }

    .fieldValueArea {
        vertical-align: top;
        background-color: #fffff0;
    }

    td.fieldLabelArea, td.fieldValueArea {
        padding: 3px;
    }
</style>

<%
    boolean pageNumber = true;
    String pageNumberString = request.getParameter("pageNumber");
    if(pageNumberString != null && !pageNumberString.isEmpty() && pageNumberString.equals("false"))
        pageNumber = false;
    boolean forList = false;
    String forListString = request.getParameter("forList");
    if(forListString != null && !forListString.isEmpty() && forListString.equals("true"))
        forList = true;
    int rowPerPage = 30;
    if(forList) {
        Object pageSizeObject = request.getSession().getAttribute("common.search.pageSize");
        String pageSize = "30";
        if(pageSizeObject != null && pageSizeObject instanceof String && !((String)pageSizeObject).isEmpty())
            pageSize = (String) pageSizeObject;
        rowPerPage = Integer.parseInt(pageSize);
    }
    FormDef formDef = (FormDef) request.getAttribute("form-def");
    String prefix = formDef.getParameterPrefix() == null || formDef.getParameterPrefix().isEmpty() ? "" : formDef.getParameterPrefix().concat(".");
    FormManager formManager = (FormManager) request.getAttribute("form-manager");
    String title = "";
    String[] split = formDef.getName().split("@");
    String formActionUrl = split[0] + "?method=" + split[1] + "&persist=true";
    String formStyle = "margin: 0px; background-color: #fffff0;";
    if(formDef.getControlInRow() > 1) {
        formStyle = formStyle.concat(" padding: 0 8%;");
    }
    String fundType = (String) request.getAttribute("fund-type");
%>
<%=FormControlUtils.getStyle(formDef.getTheme())%>

<script language="javascript">
    function multiSelectCommaSeperated(nameClass, name) {
        // console.log("multiselect: " + nameClass);
        var selects = [];
        $.each($("." + nameClass + " option:selected"), function(){
            selects.push($(this).val());
        });
        // console.log("You have selected the country - " + selects.join(", "));
        document.getElementsByName(name)[0].value = selects.join(",");
    }

    function checkboxClicked(name) {
        console.log("checked : " + name);
        if(document.getElementsByName("checkbox." + name)[0].checked == false) {
            document.getElementsByName(name)[0].value = 0;
        } else {
            document.getElementsByName(name)[0].value = 1;
        }
    }

    function resetSearchPanel() {
        <%
        for(ElementControl elementControl : formDef.getControls()) {
            if(!elementControl.getType().equalsIgnoreCase("empty")) {
                String d = "document.forms[0].elements['" + prefix.concat(elementControl.getName()) + "'].value = '';";
        %>
        <%=d%>
        <%
            }
            if(elementControl.getType().equalsIgnoreCase("select-multiple")) {
                String d = "$('select[name =\"" + "multiselect." + prefix.concat(elementControl.getName()) + "\"]').children().removeAttr('selected');";
        %>
        <%=d%>
        <%
            } else if(elementControl.getType().equalsIgnoreCase("checkbox")) {
                boolean tt = elementControl.getDefaultValue() != null && elementControl.getDefaultValue().equalsIgnoreCase("checked") ? true : false;
                String d = "$('input[name =\"" + "checkbox." + prefix.concat(elementControl.getName()) + "\"]').prop('checked', " + (tt ? "true" : "false") + ");";
        %>
        <%=d%>
        <%
            }
        }
        %>
    }

    var dpOptions = {
        buttonsColor: "red",
        forceFarsiDigits: true,
        gotoToday: true,
        markToday: true,
        sync: true,
        markHolidays: true,
        highlightSelectedDay: true,
        nextButtonIcon: "img/next.png",
        previousButtonIcon: "img/prev.png"
    };

    var dateFields = [
        <%
            for(ElementControl elementControl : formDef.getControls()) {
                if(elementControl.getType().equals("date")) {
        %>

        "<%=prefix.concat(elementControl.getName())%>",

        <%
                }
            }
        %>
    ];

    $(document).ready(function () {
        $.each(dateFields, function (key, value) {
            kamaDatepicker(value.replace(/\./g, '_'), dpOptions);
        });

        <%
            for(ElementControl elementControl : formDef.getControls()) {
                if(elementControl.getCopyOnBlur() != null && !elementControl.getCopyOnBlur().isEmpty()) {
        %>
        $("input[name='<%=formDef.getParameterPrefix().concat(".").concat(elementControl.getName())%>']").blur(function() {
            if($("input[name='<%=formDef.getParameterPrefix().concat(".").concat(elementControl.getCopyOnBlur())%>']").val().length === 0) {
                $("input[name='<%=formDef.getParameterPrefix().concat(".").concat(elementControl.getCopyOnBlur())%>']").val(
                    $("input[name='<%=formDef.getParameterPrefix().concat(".").concat(elementControl.getName())%>']").val());
            }
        });

        $("input[name='<%=formDef.getParameterPrefix().concat(".").concat(elementControl.getName())%>']").change(function() {
            if($("input[name='<%=formDef.getParameterPrefix().concat(".").concat(elementControl.getCopyOnBlur())%>']").val().length === 0) {
                $("input[name='<%=formDef.getParameterPrefix().concat(".").concat(elementControl.getCopyOnBlur())%>']").val(
                    $("input[name='<%=formDef.getParameterPrefix().concat(".").concat(elementControl.getName())%>']").val());
            }
        });
        <%
            }
        }
        %>
    });

    function checkForSubmit() {
        <%
        for (ElementControl elementControl : formDef.getControls()) {
            if(elementControl.isRequired()) {
        %>
        if(!$('#<%=prefix.concat(elementControl.getName()).replace(".", "_")%>').val()) {
            alert("(<%=formDef.getPropertyValue(elementControl.getTitle())%>) باید مقدار داشته باشد");
            return false;
        }
        <%
            }
        }
        %>
        return true;
    }
</script>

<html:form target="" action="<%=formActionUrl%>" style="<%=formStyle%>" onsubmit="return checkForSubmit()">
    <table border="0px" width="100%" cellpadding="0px" cellspacing="0" style="border-collapse: collapse;" class="content">
        <tr class="button-box">
            <td colspan="<%=2 * formDef.getControlInRow()%>" align=left style="padding-bottom: 6px;">&nbsp;</td>
        </tr>

        <%
            for(ElementButton elementButton : formDef.getButtons()) {
                if(elementButton.getType().equals("submit") && elementButton.getActivities() != null && !elementButton.getActivities().isEmpty()) {
        %>

        <input type="hidden" name="print-activity" value="" />
        <input type="hidden" name="activity" value="<%=elementButton.getActivities().stream().collect(Collectors.joining(","))%>" />

        <%
                }
            }
        %>

        <%
            int i = formDef.getControlInRow();
            for(ElementControl elementControl : formDef.getControls()) {
//                if(elementControl.getType().equalsIgnoreCase("select") || elementControl.getType().equalsIgnoreCase("select-multiple")) {
//                    List l = (List) request.getAttribute(elementControl.getItems());
//                    if(l.size() <= 1)
//                        continue;
//                }
        %>
        <%
            if(elementControl.getType().equals("hidden")) {
        %>

        <%=FormControlUtils.getTextHidden(prefix.concat(elementControl.getName()), request, false)%>

        <%
                continue;
            }
        %>

        <%
            if(i == formDef.getControlInRow()) {
        %>
        <tr>
            <%
                }
            %>

            <%
                if(elementControl.getType().equals("empty") || (!elementControl.getForFundType().isEmpty() && !elementControl.getForFundType().equalsIgnoreCase(fundType))) {
            %>
            <td colspan="<%=2%>" width="<%=100/formDef.getControlInRow()*i%>%" class="fieldValueArea" >&nbsp;</td>
            <%
                } else {
            %>

            <td width="<%=40/formDef.getControlInRow()%>%" class="fieldLabelArea" style="padding-bottom: 13px !important; vertical-align:top;">
                <%
                    if(elementControl.isRequired()) {
                %>
                <span style="color:red; font-size: 14px;" class="form-control-lable">*</span>
                <%
                    }
                %>
                <label class="form-control-lable">
                    <%=formDef.getPropertyValue(elementControl.getTitle())%>:
                </label>
            </td>
            <td width="<%=60/formDef.getControlInRow()%>%" class="fieldValueArea" style="vertical-align:top;">
                <%
                    if(elementControl.getType().equals("select") || elementControl.getType().equals("select-multiple")) {
                        boolean multiple = elementControl.getType().equals("select-multiple");
                        Map<String, String> listMap = formManager.getListMap(
                                request.getAttribute(elementControl.getItems()),
                                elementControl.getOptionTitle(), elementControl.getOptionValue());
                %>
                <%=FormControlUtils.getSelect(prefix.concat(elementControl.getName()), elementControl.getSelectDefaultItem(), request, false, listMap, false, true, multiple)%>
                <%
                } else if(elementControl.getType().equals("date")) {
                %>

                <%=FormControlUtils.getInput(elementControl, request, false, prefix)%>

                <%
                } else if(elementControl.getType().equals("number")) {
                %>

                <%=FormControlUtils.getInput(prefix.concat(elementControl.getName()),
                        request, false, "15", "onkeypress=\"return autoMask(this,event,'###############');\"", elementControl.isDisabled())%>

                <%
                    if(elementControl.getSearchBox() != null && !elementControl.getSearchBox().isEmpty()) {
                        if(elementControl.getSearchBox().equalsIgnoreCase("GL")) {
                %>

                <a href="javascript:loadwindowex('generalLedger.do?method=list&mode=popup&new_search=true','800','400',0)" onclick="setSearchBoxName('<%=prefix.concat(elementControl.getName())%>')">
                    <img border="0" src="images/more.gif" alt="انتخاب" title="انتخاب">
                </a>

                <%
                    } else if (elementControl.getSearchBox().equalsIgnoreCase("SL")) {
                %>
                <a href="javascript:loadwindowex('subsidiaryLedger.do?method=list&mode=popup&new_search=true','800','400',0)" onclick="setSearchBoxName('<%=prefix.concat(elementControl.getName())%>')">
                    <img border="0" src="images/more.gif" alt="انتخاب" title="انتخاب">
                </a>
                <%
                } else if (elementControl.getSearchBox().equalsIgnoreCase("DL")) {
                %>
                <a href="javascript:loadwindowex('detailLedger.do?method=list&mode=popup&new_search=true','800','400',0)" onclick="setSearchBoxName('<%=prefix.concat(elementControl.getName())%>')">
                    <img border="0" src="images/more.gif" alt="انتخاب" title="انتخاب">
                </a>
                <%
                    }
                    }
                %>

                <%
                } else if(elementControl.getType().equals("string")) {
                %>

                <%=FormControlUtils.getInput(prefix.concat(elementControl.getName()), request, false, "12", elementControl.isDisabled())%>
                <%
                    if(elementControl.getSearchBox() != null && !elementControl.getSearchBox().isEmpty()) {
                %>

                <a href="javascript:loadwindowex('subsidiaryLedger.do?method=list&mode=popup&new_search=true','800','400',0)" onclick="setSearchBoxName(<%=prefix.concat(elementControl.getName())%>)">
                    <img border="0" src="images/more.gif" alt="انتخاب" title="انتخاب">
                </a>

                <%
                    }
                %>
                <%
                } else if(elementControl.getType().equals("text")) {
                %>


                <%
                } else if(elementControl.getType().equals("checkbox")) {
                %>

                <%=FormControlUtils.getCheckBox(elementControl, request, false, prefix)%>

                <%
                    }
                %>
            </td>

            <%
                }
                if(--i <= 0) {
                    i = formDef.getControlInRow();
            %>
        </tr>
        <%
            }
        %>

        <%
            }
        %>

        <%
            if(i != formDef.getControlInRow() && i > 0) {
        %>
        <td colspan="<%=2 * i%>" width="<%=100/formDef.getControlInRow()*i%>%" class="fieldValueArea">&nbsp;</td>
        </tr>
        <%
            }
        %>
        <tr class="button-box">
            <td colspan="<%=2 * formDef.getControlInRow()%>" align=left style="padding-bottom: 6px;">
                <%
                    for(ElementButton elementButton : formDef.getButtons()) {
                %>

                <%
                    if(elementButton.getType().equals("submit")) {
                        String activity = "";
                        if(elementButton.getActivities() != null && !elementButton.getActivities().isEmpty()) {
                            activity = elementButton.getActivities().stream().collect(Collectors.joining(","));
                        }
                %>
                <html:submit styleClass="" property="<%=activity%>">
                    <%=formDef.getPropertyValue(elementButton.getTitle())%>
                </html:submit>&nbsp;
                <%
                } else if(elementButton.getType().equals("reset")) {
                %>
                <button onclick="resetSearchPanel()" class="" type="button">
                    <%=formDef.getPropertyValue(elementButton.getTitle())%>
                </button>&nbsp;
                <%
                } else if(elementButton.getType().equals("redirect")) {
                %>
                <button class="" onclick="location = 'forward.jsp?forward=<%=elementButton.getReturnUrl()%>'" type="button" onblur="setNextFocus('return')">
                    <%=formDef.getPropertyValue(elementButton.getTitle())%>
                </button>&nbsp;
                <%
                    }
                %>

                <%
                    }
                %>
                    <%--<button onclick="resetSearchPanel()" type="button"><bean:message key="button.reset"/></button>&nbsp;--%>
                    <%--<html:submit styleClass="button" ><bean:message key="button.save"/></html:submit>&nbsp;--%>
            </td>
        </tr>
        <%
            if(forList && pageNumber) {
        %>
        <tr>
            <%
                if(formDef.getControlInRow() > 1) {
            %>
            <td colspan="<%=2 * (formDef.getControlInRow() - 1)%>" width="<%=100/formDef.getControlInRow()*i%>%" class="fieldValueArea">&nbsp;</td>
            <%
                }
            %>
            <td width="100%" colspan="2" class="fieldLabelArea">
                <bean:message key="general.pageNumber"/>:<input type="text"  onkeypress="return autoMask(this,event,'####');" size="3" name="common.search.pageSize" value="<%=rowPerPage%>" maxLength="4">&nbsp;
            </td>
        </tr>
        <%
            }
        %>
    </table>
</html:form>

</body>
</html>
<%--<html:javascript formName="customerMessageForm" staticJavascript="false" cdata="false"/>--%>
<%--<script type="text/javascript" src="<c:url value="/scripts/validator.jsp"/>"></script>--%>