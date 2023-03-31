using CMS.Models;
using RestSharp;

public interface IInterviewer
{
    /*IEnumerable<InterviewerModel> GetAllInterviewersData();*/

    public RestResponse Interviewerlist();

    public RestResponse AddInterviewerlist(InterviewerModel InterviewerData);

    public RestResponse UpdateInterviewerlist(InterviewerModel updateInterviewerData);

    public RestResponse DeleteIntervieweritem(InterviewerModel InterviewerId);
}
