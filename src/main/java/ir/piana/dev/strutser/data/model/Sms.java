package ir.piana.dev.strutser.data.model;

public class Sms {
  private Long smsId;
  private String fromNumber;
  private String toNumber;
  private String content;
  private String requestDate;
  private String requestTime;
  private long   sendStatus;
  private long   smsType;
  private String sendDate;
  private String sendTime;
  private String errorMessage;
  private String response;


  public Sms() {
  }


  public Sms(String fromNumber, String toNumber, String content, String requestDate, String requestTime, long sendStatus, long smsType) {
    this.fromNumber = fromNumber;
    this.toNumber = toNumber;
    this.content = content;
    this.requestDate = requestDate;
    this.requestTime = requestTime;
    this.sendStatus = sendStatus;
    this.smsType = smsType;
  }

  public Long getSmsId() {
    return smsId;
  }

  public void setSmsId(Long smsId) {
    this.smsId = smsId;
  }

  public String getFromNumber() {
    return fromNumber;
  }

  public void setFromNumber(String fromNumber) {
    this.fromNumber = fromNumber;
  }

  public String getToNumber() {
    return toNumber;
  }

  public void setToNumber(String toNumber) {
    this.toNumber = toNumber;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public String getRequestDate() {
    return requestDate;
  }

  public void setRequestDate(String requestDate) {
    this.requestDate = requestDate;
  }

  public String getRequestTime() {
    return requestTime;
  }

  public void setRequestTime(String requestTime) {
    this.requestTime = requestTime;
  }

  public long getSendStatus() {
    return sendStatus;
  }

  public void setSendStatus(long sendStatus) {
    this.sendStatus = sendStatus;
  }

  public long getSmsType() {
    return smsType;
  }

  public void setSmsType(long smsType) {
    this.smsType = smsType;
  }

  public String getSendDate() {
    return sendDate;
  }

  public void setSendDate(String sendDate) {
    this.sendDate = sendDate;
  }

  public String getSendTime() {
    return sendTime;
  }

  public void setSendTime(String sendTime) {
    this.sendTime = sendTime;
  }

  public String getErrorMessage() {
    return errorMessage;
  }

  public void setErrorMessage(String errorMessage) {
    this.errorMessage = errorMessage;
  }

  public String getResponse() {
    return response;
  }

  public void setResponse(String response) {
    this.response = response;
  }
}
