// To parse this JSON data, do
//
//     final feeData = feeDataFromJson(jsonString);

import 'dart:convert';

List<FeeData> feeDataFromJson(String str) => List<FeeData>.from(json.decode(str).map((x) => FeeData.fromJson(x)));

String feeDataToJson(List<FeeData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeeData {
  int receiptNo;
  double tAmt;
  double dAmt;
  double lateFeeAmt;
  double amtRecieved;
  String paymentDate;
  String paymentMode;
  String status;
  int srNo;
  int receiptNo1;
  String date;
  String headId;
  String subheadId;
  String stdId;
  String stdName;
  String batchId;
  String batchName;
  int id;
  String uuid;
  String studentId;
  String name;
  double tAmt1;
  double dAmt1;
  double lateFeeAmt1;
  double amtRecieved1;
  String installmentId;
  String paymentDate1;
  String paymentMode1;
  String bankName;
  String chequeNo;
  dynamic chequeDate;
  String chequeStatus;
  String status1;
  String financialYear;
  dynamic dateChqUpdated;
  String onAccountOf;
  String dtsOnAccountOf;
  double cgstPercent;
  double sgstPercent;
  dynamic cgstAmt;
  dynamic sgstAmt;
  dynamic y201718;
  dynamic y201819;
  dynamic y201920;
  dynamic y202021;
  String type;
  String receiptNoTxt;
  double booksFees;
  int orgId;
  String reference;

  FeeData({
    required this.receiptNo,
    required this.tAmt,
    required this.dAmt,
    required this.lateFeeAmt,
    required this.amtRecieved,
    required this.paymentDate,
    required this.paymentMode,
    required this.status,
    required this.srNo,
    required this.receiptNo1,
    required this.date,
    required this.headId,
    required this.subheadId,
    required this.stdId,
    required this.stdName,
    required this.batchId,
    required this.batchName,
    required this.id,
    required this.uuid,
    required this.studentId,
    required this.name,
    required this.tAmt1,
    required this.dAmt1,
    required this.lateFeeAmt1,
    required this.amtRecieved1,
    required this.installmentId,
    required this.paymentDate1,
    required this.paymentMode1,
    required this.bankName,
    required this.chequeNo,
    required this.chequeDate,
    required this.chequeStatus,
    required this.status1,
    required this.financialYear,
    required this.dateChqUpdated,
    required this.onAccountOf,
    required this.dtsOnAccountOf,
    required this.cgstPercent,
    required this.sgstPercent,
    required this.cgstAmt,
    required this.sgstAmt,
    required this.y201718,
    required this.y201819,
    required this.y201920,
    required this.y202021,
    required this.type,
    required this.receiptNoTxt,
    required this.booksFees,
    required this.orgId,
    required this.reference,
  });

  factory FeeData.fromJson(Map<String, dynamic> json) => FeeData(
    receiptNo: json["Receipt_No"],
    tAmt: json["T_Amt"],
    dAmt: json["D_Amt"],
    lateFeeAmt: json["Late_Fee_Amt"],
    amtRecieved: json["Amt_Recieved"],
    paymentDate: json["Payment_Date"],
    paymentMode: json["Payment_Mode"],
    status: json["Status"],
    srNo: json["Sr_No"],
    receiptNo1: json["Receipt_No1"],
    date: json["Date"],
    headId: json["Head_Id"],
    subheadId: json["Subhead_Id"],
    stdId: json["Std_Id"],
    stdName: json["Std_Name"],
    batchId: json["Batch_ID"],
    batchName: json["Batch_Name"],
    id: json["ID"],
    uuid: json["UUID"],
    studentId: json["Student_Id"],
    name: json["Name"],
    tAmt1: json["T_Amt1"],
    dAmt1: json["D_Amt1"],
    lateFeeAmt1: json["Late_Fee_Amt1"],
    amtRecieved1: json["Amt_Recieved1"],
    installmentId: json["Installment_Id"],
    paymentDate1: json["Payment_Date1"],
    paymentMode1: json["Payment_Mode1"],
    bankName: json["Bank_Name"],
    chequeNo: json["Cheque_No"],
    chequeDate: json["Cheque_Date"],
    chequeStatus: json["Cheque_Status"],
    status1: json["Status1"],
    financialYear: json["Financial_Year"],
    dateChqUpdated: json["Date_Chq_Updated"],
    onAccountOf: json["On_Account_Of"],
    dtsOnAccountOf: json["DTS_On_Account_Of"],
    cgstPercent: json["CGST_Percent"],
    sgstPercent: json["SGST_Percent"],
    cgstAmt: json["CGST_Amt"],
    sgstAmt: json["SGST_Amt"],
    y201718: json["Y2017_18"],
    y201819: json["Y2018_19"],
    y201920: json["Y2019_20"],
    y202021: json["Y2020_21"],
    type: json["Type"],
    receiptNoTxt: json["Receipt_No_Txt"],
    booksFees: json["Books_Fees"],
    orgId: json["Org_Id"],
    reference: json["Reference"],
  );

  Map<String, dynamic> toJson() => {
    "Receipt_No": receiptNo,
    "T_Amt": tAmt,
    "D_Amt": dAmt,
    "Late_Fee_Amt": lateFeeAmt,
    "Amt_Recieved": amtRecieved,
    "Payment_Date": paymentDate,
    "Payment_Mode": paymentMode,
    "Status": status,
    "Sr_No": srNo,
    "Receipt_No1": receiptNo1,
    "Date": date,
    "Head_Id": headId,
    "Subhead_Id": subheadId,
    "Std_Id": stdId,
    "Std_Name": stdName,
    "Batch_ID": batchId,
    "Batch_Name": batchName,
    "ID": id,
    "UUID": uuid,
    "Student_Id": studentId,
    "Name": name,
    "T_Amt1": tAmt1,
    "D_Amt1": dAmt1,
    "Late_Fee_Amt1": lateFeeAmt1,
    "Amt_Recieved1": amtRecieved1,
    "Installment_Id": installmentId,
    "Payment_Date1": paymentDate1,
    "Payment_Mode1": paymentMode1,
    "Bank_Name": bankName,
    "Cheque_No": chequeNo,
    "Cheque_Date": chequeDate,
    "Cheque_Status": chequeStatus,
    "Status1": status1,
    "Financial_Year": financialYear,
    "Date_Chq_Updated": dateChqUpdated,
    "On_Account_Of": onAccountOf,
    "DTS_On_Account_Of": dtsOnAccountOf,
    "CGST_Percent": cgstPercent,
    "SGST_Percent": sgstPercent,
    "CGST_Amt": cgstAmt,
    "SGST_Amt": sgstAmt,
    "Y2017_18": y201718,
    "Y2018_19": y201819,
    "Y2019_20": y201920,
    "Y2020_21": y202021,
    "Type": type,
    "Receipt_No_Txt": receiptNoTxt,
    "Books_Fees": booksFees,
    "Org_Id": orgId,
    "Reference": reference,
  };
}
