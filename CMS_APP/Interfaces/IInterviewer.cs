using CMS.Models;
using RestSharp;

public interface IInterviewer
{
    public RestResponse Interviewerlist(int pageNumber, int pageSize, out int totalItems);

    public RestResponse AddInterviewerlist(InterviewerModel InterviewerData);

    public RestResponse UpdateInterviewerlist(InterviewerModel updateInterviewerData);

    public RestResponse DeleteIntervieweritem(InterviewerModel InterviewerId);
}
