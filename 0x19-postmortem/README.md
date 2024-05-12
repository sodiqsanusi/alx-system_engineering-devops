# Incident Report: Backend Infrastructure Outage
> This report is a postmortem on the failure of our backend infrastructure to handle requests, happened on the date: May 5, 2024.

## Issue Summary:

From 10:12 AM to 11:25 AM GMT, all requests made by users on the website and mobile app were unsuccessful. Requests made were unresponsive and ended in a 408 "Request Timeout" error, affecting 90% of our total traffic for the outage period. The root cause of this issue was a configuration change which initiated a firewall reset, denying HTTP/HTTPS access to the load balancers.

## Timeline (all in GMT):

* **10:05 AM:** Changes were made to the configurations of our load balancer.
    
* **10:12 AM:** Outage begins.
    
* **10:15 AM:** Monitoring service alerted on-call engineer.
    
* **10:23 AM:** Problem pinpointed to be from the load balancers.
    
* **10:49 AM:** Rolled back recent configuration changes (requests remained unsuccessful.)
    
* **11:07 AM:** Firewall was identified as root cause of issue.
    
* **11:16 AM:** HTTP and HTTPS ports manually allowed in firewall config.
    
* **11:18 AM:** Load Balancer restarted.
    
* **11:25 AM:** Requests from clients 100% successful.
    

## Root Cause:

At 10:05 AM GMT, a routine configuration change was made to the load balancer's environmental variables. This change then led to the updating of some outdated packages, of which the firewall package was one. The update caused a reset in the firewall settings, taking it back to its default (which does not allow for HTTP and HTTPS naturally).

With the HTTPS/HTTP ports blocked by the firewall, requests from our web and mobile applications—both using HTTPS—could not go through. This led to the outage that began around 10:12 AM GMT.

## Resolution and recovery:

At 10:15 AM GMT, the monitoring service alerted the on-call engineer over a low preset limit reached at responses delivered over requests made. This alongside an increased number of complaints made the engineer escalate the issue as soon as it happened.

After making successful requests to the servers themselves without issue, it was determined that the load balancer was the major system causing the issue. Checking the logs of the load balancer revealed a recent routine automated configuration change, and it was assumed that the change was the root cause. A rollback of the configuration state was attempted at 10:49 AM GMT.

The rollback was successful, but requests made were still failing. After some additional checks, it turned out that the firewall was rejecting requests made to the HTTP and HTTP ports, and this was manually added to the firewall config. The load balancer was restarted at 11:18 AM GMT, and after the reboot was completed at 11:15 AM GMT, resolved requests from clients were back at a 100% success rate.

## Corrective and Preventative Measures:

After a review of the incident, actions that we believe will address the underlying causes of the issue and to help prevent recurrences are:

* Adding automated checks that detect changes in the load balancer's environment.
    
* Running checks after any configuration change in both the servers and the load balancer (whether the change is considered routine or not).
    
* Adding vital ports to the firewall default settings.
    

---

We are committed to improving our technology and operational processes to prevent outages, and we fully appreciate your patience and continued support.

**Report by:** *Sodiq "Ade" Sanusi*, Site Reliability Engineer

<div data-node-type="callout">
<div data-node-type="callout-emoji">💻</div>
<div data-node-type="callout-text"><strong>NB: </strong>This experience was a personal experience, not a company-wide one. And this postmortem article is part of an assignment at my Software Engineering course.</div>
</div>
