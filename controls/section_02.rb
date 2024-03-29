#
# Profile:: inspec_os_win10_21h1_cis
# Control:: section_02
#
# Copyright:: 2021, The Authors, All Rights Reserved.

control '2.2.1_L1_Ensure_Access_Credential_Manager_as_a_trusted_caller_is_set_to_No_One' do
  title "(L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'"
  desc  "
    This security setting is used by Credential Manager during Backup and Restore. No accounts should have this user right, as it is only assigned to Winlogon. Users' saved credentials might be compromised if this user right is assigned to other entities.

    The recommended state for this setting is: No One.

    Rationale: If an account is given this right the user of the account may create an application that calls into Credential Manager and is returned the credentials for another user.
  "
  impact 1.0
  tag cce: 'CCE-35457-1'
  describe 'Security Policy SeTrustedCredManAccessPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeTrustedCredManAccessPrivilege) }
    it { should be_empty }
  end
end

control '2.2.2_L1_Ensure_Access_this_computer_from_the_network_is_set_to_Administrators_Remote_Desktop_Users' do
  title "(L1) Ensure 'Access this computer from the network' is set to 'Administrators, Remote Desktop Users'"
  desc  "
    This policy setting allows other users on the network to connect to the computer and is required by various network protocols that include Server Message Block (SMB)-based protocols, NetBIOS, Common Internet File System (CIFS), and Component Object Model Plus (COM+).

    The recommended state for this setting is: Administrators.

    Rationale: Users who can connect from their computer to the network can access resources on target computers for which they have permission. For example, the Access this computer from the network user right is required for users to connect to shared printers and folders. If this user right is assigned to the Everyone group, then anyone in the group will be able to read the files in those shared folders. However, this situation is unlikely for new installations of Windows Server 2003 with Service Pack 1 (SP1), because the default share and NTFS permissions in Windows Server 2003 do not include the Everyone group. This vulnerability may have a higher level of risk for computers that you upgrade from Windows NT 4.0 or Windows 2000, because the default permissions for these operating systems are not as restrictive as the default permissions in Windows Server 2003.
  "
  impact 1.0
  tag cce: 'CCE-32928-4'
  describe 'Security Policy SeNetworkLogonRight' do
    subject { Array(security_policy(translate_sid: true).SeNetworkLogonRight) }
    it { should match_array ['BUILTIN\\Administrators', 'BUILTIN\\Remote Desktop Users'] }
  end
end

control '2.2.3_L1_Ensure_Act_as_part_of_the_operating_system_is_set_to_No_One' do
  title "(L1) Ensure 'Act as part of the operating system' is set to 'No One'"
  desc  "
    This policy setting allows a process to assume the identity of any user and thus gain access to the resources that the user is authorized to access.

    The recommended state for this setting is: No One.

    Rationale: The Act as part of the operating system user right is extremely powerful. Anyone with this user right can take complete control of the computer and erase evidence of their activities.
  "
  impact 1.0
  tag cce: 'CCE-35403-5'
  describe 'Security Policy SeTcbPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeTcbPrivilege) }
    it { should be_empty }
  end
end

control '2.2.4_L1_Ensure_Adjust_memory_quotas_for_a_process_is_set_to_Administrators_LOCAL_SERVICE_NETWORK_SERVICE' do
  title "(L1) Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE'"
  desc  "
    This policy setting allows a user to adjust the maximum amount of memory that is available to a process. The ability to adjust memory quotas is useful for system tuning, but it can be abused. In the wrong hands, it could be used to launch a denial of service (DoS) attack.

    The recommended state for this setting is: Administrators, LOCAL SERVICE, NETWORK SERVICE.

    Rationale: A user with the Adjust memory quotas for a process privilege can reduce the amount of memory that is available to any process, which could cause business-critical network applications to become slow or to fail. In the wrong hands, this privilege could be used to start a denial of service (DoS) attack.
  "
  impact 1.0
  tag cce: 'CCE-35490-2'
  describe 'Security Policy SeIncreaseQuotaPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeIncreaseQuotaPrivilege) }
    it { should match_array ['BUILTIN\\Administrators', 'NT AUTHORITY\\LOCAL SERVICE', 'NT AUTHORITY\\NETWORK SERVICE'] }
  end
end

control '2.2.5_L1_Ensure_Allow_log_on_locally_is_set_to_Administrators_Users' do
  title "(L1) Ensure 'Allow log on locally' is set to 'Administrators, Users'"
  desc  "
    This policy setting determines which users can interactively log on to computers in your environment. Logons that are initiated by pressing the CTRL+ALT+DEL key sequence on the client computer keyboard require this user right. Users who attempt to log on through Terminal Services or IIS also require this user right.

    The Guest account is assigned this user right by default. Although this account is disabled by default, it's recommended that you enable this setting through Group Policy. However, this user right should generally be restricted to the Administrators and Users groups. Assign this user right to the Backup Operators group if your organization requires that they have this capability.

    The recommended state for this setting is: Administrators, Users.

    Rationale: Any account with the Allow log on locally user right can log on at the console of the computer. If you do not restrict this user right to legitimate users who need to be able to log on to the console of the computer, unauthorized users could download and run malicious software to elevate their privileges.
  "
  impact 1.0
  tag cce: 'CCE-35640-2'
  describe 'Security Policy SeInteractiveLogonRight' do
    subject { Array(security_policy(translate_sid: true).SeInteractiveLogonRight) }
    it { should match_array ['BUILTIN\\Administrators', 'BUILTIN\\Users'] }
  end
end

control '2.2.6_L1_Ensure_Allow_log_on_through_Remote_Desktop_Services_is_set_to_Administrators_Remote_Desktop_Users' do
  title "(L1) Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users'"
  desc  "
    This policy setting determines which users or groups have the right to log on as a Terminal Services client. Remote desktop users require this user right. If your organization uses Remote Assistance as part of its help desk strategy, create a group and assign it this user right through Group Policy. If the help desk in your organization does not use Remote Assistance, assign this user right only to the Administrators group or use the restricted groups feature to ensure that no user accounts are part of the Remote Desktop Users group.

    Restrict this user right to the Administrators group, and possibly the Remote Desktop Users group, to prevent unwanted users from gaining access to computers on your network by means of the Remote Assistance feature.

    The recommended state for this setting is: Administrators, Remote Desktop Users

    Rationale: Any account with the Allow log on through Terminal Services user right can log on to the remote console of the computer. If you do not restrict this user right to legitimate users who need to log on to the console of the computer, unauthorized users could download and run malicious software to elevate their privileges.
  "
  impact 1.0
  tag cce: 'CCE-33035-7'
  describe 'Security Policy SeRemoteInteractiveLogonRight' do
    subject { Array(security_policy(translate_sid: true).SeRemoteInteractiveLogonRight) }
    it { should match_array ['BUILTIN\\Administrators', 'BUILTIN\\Remote Desktop Users'] }
  end
end

control '2.2.7_L1_Ensure_Back_up_files_and_directories_is_set_to_Administrators' do
  title "(L1) Ensure 'Back up files and directories' is set to 'Administrators'"
  desc  "
    This policy setting allows users to circumvent file and directory permissions to back up the system. This user right is enabled only when an application (such as NTBACKUP) attempts to access a file or directory through the NTFS file system backup application programming interface (API). Otherwise, the assigned file and directory permissions apply.

    The recommended state for this setting is: Administrators.

    Rationale: Users who are able to back up data from a computer could take the backup media to a non-domain computer on which they have administrative privileges and restore the data. They could take ownership of the files and view any unencrypted data that is contained within the backup set.
  "
  impact 1.0
  tag cce: 'CCE-35699-8'
  describe 'Security Policy SeBackupPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeBackupPrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.8_L1_Ensure_Change_the_system_time_is_set_to_Administrators_LOCAL_SERVICE' do
  title "(L1) Ensure 'Change the system time' is set to 'Administrators, 'LOCAL SERVICE'"
  desc  "
    This policy setting determines which users and groups can change the time and date on the internal clock of the computers in your environment. Users who are assigned this user right can affect the appearance of event logs. When a computer's time setting is changed, logged events reflect the new time, not the actual time that the events occurred.

    When configuring a user right in the SCM enter a comma delimited list of accounts. Accounts can be either local or located in Active Directory, they can be groups, users, or computers.

    **Note:** Discrepancies between the time on the local computer and on the domain controllers in your environment may cause problems for the Kerberos authentication protocol, which could make it impossible for users to log on to the domain or obtain authorization to access domain resources after they are logged on. Also, problems will occur when Group Policy is applied to client computers if the system time is not synchronized with the domain controllers.

    The recommended state for this setting is: Administrators, LOCAL SERVICE.

    Rationale: Users who can change the time on a computer could cause several problems. For example, time stamps on event log entries could be made inaccurate, time stamps on files and folders that are created or modified could be incorrect, and computers that belong to a domain may not be able to authenticate themselves or users who try to log on to the domain from them. Also, because the Kerberos authentication protocol requires that the requestor and authenticator have their clocks synchronized within an administrator-defined skew period, an attacker who changes a computer's time may cause that computer to be unable to obtain or grant Kerberos tickets.

    The risk from these types of events is mitigated on most domain controllers, member servers, and end-user computers because the Windows Time service automatically synchronizes time with domain controllers in the following ways:

    * All client desktop computers and member servers use the authenticating domain controller as their inbound time partner.
    * All domain controllers in a domain nominate the primary domain controller (PDC) emulator operations master as their inbound time partner.
    * All PDC emulator operations masters follow the hierarchy of domains in the selection of their inbound time partner.
    * The PDC emulator operations master at the root of the domain is authoritative for the organization. Therefore it is recommended that you configure this computer to synchronize with a reliable external time server.
    This vulnerability becomes much more serious if an attacker is able to change the system time and then stop the Windows Time service or reconfigure it to synchronize with a time server that is not accurate.
  "
  impact 1.0
  tag cce: 'CCE-33094-4'
  describe 'Security Policy SeSystemtimePrivilege' do
    subject { Array(security_policy(translate_sid: true).SeSystemtimePrivilege) }
    it { should match_array ['BUILTIN\\Administrators', 'NT AUTHORITY\\LOCAL SERVICE'] }
  end
end

control '2.2.9_L1_Ensure_Change_the_time_zone_is_set_to_Administrators_LOCAL_SERVICE_Users' do
  title "(L1) Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE, Users'"
  desc  "
    This setting determines which users can change the time zone of the computer. This ability holds no great danger for the computer and may be useful for mobile workers.

    The recommended state for this setting is: Administrators, LOCAL SERVICE, Users.

    Rationale: Changing the time zone represents little vulnerability because the system time is not affected. This setting merely enables users to display their preferred time zone while being synchronized with domain controllers in different time zones.
  "
  impact 1.0
  tag cce: 'CCE-33431-8'
  describe 'Security Policy SeTimeZonePrivilege' do
    subject { Array(security_policy(translate_sid: true).SeTimeZonePrivilege) }
    it { should match_array ['BUILTIN\\Administrators', 'NT AUTHORITY\\LOCAL SERVICE', 'BUILTIN\\Users'] + (users.where { username.casecmp('Users') == 0 }.uids.entries + groups.where { name.casecmp('Users') == 0 }.gids.entries) }
  end
end

control '2.2.10_L1_Ensure_Create_a_pagefile_is_set_to_Administrators' do
  title "(L1) Ensure 'Create a pagefile' is set to 'Administrators'"
  desc  "
    This policy setting allows users to change the size of the pagefile. By making the pagefile extremely large or extremely small, an attacker could easily affect the performance of a compromised computer.

    The recommended state for this setting is: Administrators.

    Rationale: Users who can change the page file size could make it extremely small or move the file to a highly fragmented storage volume, which could cause reduced computer performance.
  "
  impact 1.0
  tag cce: 'CCE-33051-4'
  describe 'Security Policy SeCreatePagefilePrivilege' do
    subject { Array(security_policy(translate_sid: true).SeCreatePagefilePrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.11_L1_Ensure_Create_a_token_object_is_set_to_No_One' do
  title "(L1) Ensure 'Create a token object' is set to 'No One'"
  desc  "
    This policy setting allows a process to create an access token, which may provide elevated rights to access sensitive data.

    The recommended state for this setting is: No One.

    Rationale: A user account that is given this user right has complete control over the system and can lead to the system being compromised. It is highly recommended that you do not assign any user accounts this right.

    The operating system examines a user's access token to determine the level of the user's privileges. Access tokens are built when users log on to the local computer or connect to a remote computer over a network. When you revoke a privilege, the change is immediately recorded, but the change is not reflected in the user's access token until the next time the user logs on or connects. Users with the ability to create or modify tokens can change the level of access for any currently logged on account. They could escalate their own privileges or create a DoS condition.
  "
  impact 1.0
  tag cce: 'CCE-33779-0'
  describe 'Security Policy SeCreatePagefilePrivilege' do
    subject { Array(security_policy(translate_sid: true).SeCreateTokenPrivilege) }
    it { should be_empty }
  end
end

control '2.2.12_L1_Ensure_Create_global_objects_is_set_to_Administrators_LOCAL_SERVICE_NETWORK_SERVICE_SERVICE' do
  title "(L1) Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'"
  desc  "
    This policy setting determines whether users can create global objects that are available to all sessions. Users can still create objects that are specific to their own session if they do not have this user right.

    Users who can create global objects could affect processes that run under other users' sessions. This capability could lead to a variety of problems, such as application failure or data corruption.

    The recommended state for this setting is: Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE.

    Rationale: Users who can create global objects could affect Windows services and processes that run under other user or system accounts. This capability could lead to a variety of problems, such as application failure, data corruption and elevation of privilege.
  "
  impact 1.0
  tag cce: 'CCE-33095-1'
  describe 'Security Policy SeCreateGlobalPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeCreateGlobalPrivilege) }
    it { match_array ['BUILTIN\\Administrators', 'NT AUTHORITY\\LOCAL SERVICE', 'NT AUTHORITY\\NETWORK SERVICE', 'NT AUTHORITY\\SERVICE'] }
  end
end

control '2.2.13_L1_Ensure_Create_permanent_shared_objects_is_set_to_No_One' do
  title "(L1) Ensure 'Create permanent shared objects' is set to 'No One'"
  desc  "
    This user right is useful to kernel-mode components that extend the object namespace. However, components that run in kernel mode have this user right inherently. Therefore, it is typically not necessary to specifically assign this user right.

    The recommended state for this setting is: No One.

    Rationale: Users who have the Create permanent shared objects user right could create new shared objects and expose sensitive data to the network.
  "
  impact 1.0
  tag cce: 'CCE-33780-8'
  describe 'Security Policy SeCreatePermanentPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeCreatePermanentPrivilege) }
    it { should be_empty }
  end
end

control '2.2.14_L1_Ensure_Create_symbolic_links_is_set_to_Administrators' do
  title "(L1) Ensure 'Create symbolic links' is set to 'Administrators'"
  desc  "
    This policy setting determines which users can create symbolic links. In Windows Vista, existing NTFS file system objects, such as files and folders, can be accessed by referring to a new kind of file system object called a symbolic link. A symbolic link is a pointer (much like a shortcut or .lnk file) to another file system object, which can be a file, folder, shortcut or another symbolic link. The difference between a shortcut and a symbolic link is that a shortcut only works from within the Windows shell. To other programs and applications, shortcuts are just another file, whereas with symbolic links, the concept of a shortcut is implemented as a feature of the NTFS file system.

    Symbolic links can potentially expose security vulnerabilities in applications that are not designed to use them. For this reason, the privilege for creating symbolic links should only be assigned to trusted users. By default, only Administrators can create symbolic links.

    The recommended state for this setting is: Administrators.

    Rationale: Users who have the Create Symbolic Links user right could inadvertently or maliciously expose your system to symbolic link attacks. Symbolic link attacks can be used to change the permissions on a file, to corrupt data, to destroy data, or as a Denial of Service attack.
  "
  impact 1.0
  tag cce: 'CCE-33053-0'
  if powershell('(Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-All -Online).State').stdout.strip == 'Enabled'
    describe 'Security Policy SeCreateSymbolicLinkPrivilege' do
      subject { Array(security_policy(translate_sid: true).SeCreateSymbolicLinkPrivilege) }
      it { should match_array ['BUILTIN\\Administrators', 'NT VIRTUAL MACHINE\\Virtual Machines'] }
    end
  else
    describe 'Security Policy SeCreateSymbolicLinkPrivilege' do
      subject { Array(security_policy(translate_sid: true).SeCreateSymbolicLinkPrivilege) }
      it { should match_array ['BUILTIN\\Administrators'] }
    end
  end
end

control '2.2.15_L1_Ensure_Debug_programs_is_set_to_Administrators' do
  title "(L1) Ensure 'Debug programs' is set to 'Administrators'"
  desc  "
    This policy setting determines which user accounts will have the right to attach a debugger to any process or to the kernel, which provides complete access to sensitive and critical operating system components. Developers who are debugging their own applications do not need to be assigned this user right; however, developers who are debugging new system components will need it.

    The recommended state for this setting is: Administrators.

    Rationale: The Debug programs user right can be exploited to capture sensitive computer information from system memory, or to access and modify kernel or application structures. Some attack tools exploit this user right to extract hashed passwords and other private security information, or to insert rootkit code. By default, the Debug programs user right is assigned only to administrators, which helps to mitigate the risk from this vulnerability.
  "
  impact 1.0
  tag cce: 'CCE-33157-9'
  describe 'Security Policy SeDebugPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeDebugPrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.16_L1_Ensure_Deny_access_to_this_computer_from_the_network_to_include_Guests_Local_account' do
  title "(L1) Ensure 'Deny access to this computer from the network' to include 'Guests, Local account'"
  desc  "
    This policy setting prohibits users from connecting to a computer from across the network, which would allow users to access and potentially modify data remotely. In high security environments, there should be no need for remote users to access data on a computer. Instead, file sharing should be accomplished through the use of network servers.

    The recommended state for this setting is to include: Guests, Local account.

    **Caution:** Configuring a standalone (non-domain-joined) workstation as described above may result in an inability to remotely administer the workstation.

    Rationale: Users who can log on to the computer over the network can enumerate lists of account names, group names, and shared resources. Users with permission to access shared folders and files can connect over the network and possibly view or modify data.
  "
  impact 1.0
  tag cce: 'CCE-34173-5'
  describe 'Security Policy SeDenyNetworkLogonRight' do
    subject { ['BUILTIN\\Guests', 'BUILTIN\\Users'] }
    it { should be_in Array(security_policy(translate_sid: true).SeDenyNetworkLogonRight) }
  end
end

control '2.2.17_L1_Ensure_Deny_log_on_as_a_batch_job_to_include_Guests' do
  title "(L1) Ensure 'Deny log on as a batch job' to include 'Guests'"
  desc  "
    This policy setting determines which accounts will not be able to log on to the computer as a batch job. A batch job is not a batch (.bat) file, but rather a batch-queue facility. Accounts that use the Task Scheduler to schedule jobs need this user right.

    The **Deny log on as a batch job** user right overrides the **Log on as a batch job** user right, which could be used to allow accounts to schedule jobs that consume excessive system resources. Such an occurrence could cause a DoS condition. Failure to assign this user right to the recommended accounts can be a security risk.

    The recommended state for this setting is to include: Guests.

    Rationale: Accounts that have the Deny log on as a batch job user right could be used to schedule jobs that could consume excessive computer resources and cause a DoS condition.
  "
  impact 1.0
  tag cce: 'CCE-35461-3'
  describe 'Security Policy SeDenyBatchLogonRight' do
    subject {  ['BUILTIN\\Guests'] }
    it { should be_in Array(security_policy(translate_sid: true).SeDenyBatchLogonRight) }
  end
end

control '2.2.18_L1_Ensure_Deny_log_on_as_a_service_to_include_Guests' do
  title "(L1) Ensure 'Deny log on as a service' to include 'Guests'"
  desc  "
    This security setting determines which service accounts are prevented from registering a process as a service. This policy setting supersedes the **Log on as a service** policy setting if an account is subject to both policies.

    The recommended state for this setting is to include: Guests.

    **Note:** This security setting does not apply to the System, Local Service, or Network Service accounts.

    Rationale: Accounts that can log on as a service could be used to configure and start new unauthorized services, such as a keylogger or other malicious software. The benefit of the specified countermeasure is somewhat reduced by the fact that only users with administrative privileges can install and configure services, and an attacker who has already attained that level of access could configure the service to run with the System account.
  "
  impact 1.0
  tag cce: 'CCE-35404-3'
  describe 'Security Policy SeDenyServiceLogonRight' do
    subject { ['BUILTIN\\Guests'] }
    it { should be_in Array(security_policy(translate_sid: true).SeDenyServiceLogonRight) }
  end
end

control '2.2.19_L1_Ensure_Deny_log_on_locally_to_include_Guests' do
  title "(L1) Ensure 'Deny log on locally' to include 'Guests'"
  desc  "
    This security setting determines which users are prevented from logging on at the computer. This policy setting supersedes the **Allow log on locally** policy setting if an account is subject to both policies.

    **Important:** If you apply this security policy to the Everyone group, no one will be able to log on locally.

    The recommended state for this setting is to include: Guests.

    Rationale: Any account with the ability to log on locally could be used to log on at the console of the computer. If this user right is not restricted to legitimate users who need to log on to the console of the computer, unauthorized users might download and run malicious software that elevates their privileges.
  "
  impact 1.0
  tag cce: 'CCE-35293-0'
  describe 'Security Policy SeDenyInteractiveLogonRight' do
    subject { ['BUILTIN\\Guests'] }
    it { should be_in Array(security_policy(translate_sid: true).SeDenyInteractiveLogonRight) }
  end
end

control '2.2.20_L1_Ensure_Deny_log_on_through_Remote_Desktop_Services_to_include_Guests_Local_account' do
  title "(L1) Ensure 'Deny log on through Remote Desktop Services' to include 'Guests, Local account'"
  desc  "
    This policy setting determines whether users can log on as Terminal Services clients. After the baseline workstation is joined to a domain environment, there is no need to use local accounts to access the workstation from the network. Domain accounts can access the server for administration and end-user processing.

    The recommended state for this setting is to include: Guests, Local account.

    **Caution:** Configuring a standalone (non-domain-joined) workstation as described above may result in an inability to remotely administer the workstation.

    Rationale: Any account with the right to log on through Terminal Services could be used to log on to the remote console of the computer. If this user right is not restricted to legitimate users who need to log on to the console of the computer, unauthorized users might download and run malicious software that elevates their privileges.
  "
  impact 1.0
  tag cce: 'CCE-33787-3'
  describe 'Security Policy SeDenyRemoteInteractiveLogonRight' do
    subject { ['BUILTIN\\Guests', 'BUILTIN\\Users'] }
    it { should be_in Array(security_policy(translate_sid: true).SeDenyRemoteInteractiveLogonRight) }
  end
end

control '2.2.22_L1_Ensure_Force_shutdown_from_a_remote_system_is_set_to_Administrators' do
  title "(L1) Ensure 'Force shutdown from a remote system' is set to 'Administrators'"
  desc  "
    This policy setting allows users to shut down Windows Vista-based computers from remote locations on the network. Anyone who has been assigned this user right can cause a denial of service (DoS) condition, which would make the computer unavailable to service user requests. Therefore, it is recommended that only highly trusted administrators be assigned this user right.

    The recommended state for this setting is: Administrators.

    Rationale: Any user who can shut down a computer could cause a DoS condition to occur. Therefore, this user right should be tightly restricted.
  "
  impact 1.0
  tag cce: 'CCE-33715-4'
  describe 'Security Policy SeRemoteShutdownPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeRemoteShutdownPrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.23_L1_Ensure_Generate_security_audits_is_set_to_LOCAL_SERVICE_NETWORK_SERVICE' do
  title "(L1) Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE'"
  desc  "
    This policy setting determines which users or processes can generate audit records in the Security log.

    The recommended state for this setting is: LOCAL SERVICE, NETWORK SERVICE.

    Rationale: An attacker could use this capability to create a large number of audited events, which would make it more difficult for a system administrator to locate any illicit activity. Also, if the event log is configured to overwrite events as needed, any evidence of unauthorized activities could be overwritten by a large number of unrelated events.
  "
  impact 1.0
  tag cce: 'CCE-35363-1'
  describe 'Security Policy SeAuditPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeAuditPrivilege) }
    it { should match_array ['NT AUTHORITY\\LOCAL SERVICE', 'NT AUTHORITY\\NETWORK SERVICE'] }
  end
end

control '2.2.24_L1_Ensure_Impersonate_a_client_after_authentication_is_set_to_Administrators_LOCAL_SERVICE_NETWORK_SERVICE_SERVICE' do
  title "(L1) Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'"
  desc  "
    The policy setting allows programs that run on behalf of a user to impersonate that user (or another specified account) so that they can act on behalf of the user. If this user right is required for this kind of impersonation, an unauthorized user will not be able to convince a client to connect#x2014;for example, by remote procedure call (RPC) or named pipes#x2014;to a service that they have created to impersonate that client, which could elevate the unauthorized user's permissions to administrative or system levels.

    Services that are started by the Service Control Manager have the built-in Service group added by default to their access tokens. COM servers that are started by the COM infrastructure and configured to run under a specific account also have the Service group added to their access tokens. As a result, these processes are assigned this user right when they are started.

    Also, a user can impersonate an access token if any of the following conditions exist:
    - The access token that is being impersonated is for this user.
    - The user, in this logon session, logged on to the network with explicit credentials to create the access token.
    - The requested level is less than Impersonate, such as Anonymous or Identify.

    An attacker with the Impersonate a client after authentication user right could create a service, trick a client to make them connect to the service, and then impersonate that client to elevate the attacker's level of access to that of the client.

    The recommended state for this setting is: Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE.

    Rationale: An attacker with the Impersonate a client after authentication user right could create a service, trick a client to make them connect to the service, and then impersonate that client to elevate the attacker's level of access to that of the client.
  "
  impact 1.0
  tag cce: 'CCE-34021-6'
  describe 'Security Policy SeImpersonatePrivilege' do
    subject { Array(security_policy(translate_sid: true).SeImpersonatePrivilege) }
    it { should match_array ['BUILTIN\\Administrators', 'NT AUTHORITY\\LOCAL SERVICE', 'NT AUTHORITY\\NETWORK SERVICE', 'NT AUTHORITY\\SERVICE'] }
  end
end

control '2.2.25_L1_Ensure_Increase_scheduling_priority_is_set_to_Administrators_Window_Manager_Group' do
  title "(L1) Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager Group '"
  desc  "
    This policy setting determines whether users can increase the base priority class of a process. (It is not a privileged operation to increase relative priority within a priority class.) This user right is not required by administrative tools that are supplied with the operating system but might be required by software development tools.

    The recommended state for this setting is: Administrators.

    Rationale: A user who is assigned this user right could increase the scheduling priority of a process to Real-Time, which would leave little processing time for all other processes and could lead to a DoS condition.
  "
  impact 1.0
  tag cce: 'CCE-35178-3'
  describe 'Security Policy SeIncreaseBasePriorityPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeIncreaseBasePriorityPrivilege) }
    it { should match_array ['BUILTIN\\Administrators', 'Window Manager\\Window Manager Group'] }
  end
end

control '2.2.26_L1_Ensure_Load_and_unload_device_drivers_is_set_to_Administrators' do
  title "(L1) Ensure 'Load and unload device drivers' is set to 'Administrators'"
  desc  "
    This policy setting allows users to dynamically load a new device driver on a system. An attacker could potentially use this capability to install malicious code that appears to be a device driver. This user right is required for users to add local printers or printer drivers in Windows Vista.

    The recommended state for this setting is: Administrators.

    Rationale: Device drivers run as highly privileged code. A user who has the Load and unload device drivers user right could unintentionally install malicious code that masquerades as a device driver. Administrators should exercise greater care and install only drivers with verified digital signatures.
  "
  impact 1.0
  tag cce: 'CCE-34903-5'
  describe 'Security Policy SeLoadDriverPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeLoadDriverPrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.27_L1_Ensure_Lock_pages_in_memory_is_set_to_No_One' do
  title "(L1) Ensure 'Lock pages in memory' is set to 'No One'"
  desc  "
    This policy setting allows a process to keep data in physical memory, which prevents the system from paging the data to virtual memory on disk. If this user right is assigned, significant degradation of system performance can occur.

    The recommended state for this setting is: No One.

    Rationale: Users with the Lock pages in memory user right could assign physical memory to several processes, which could leave little or no RAM for other processes and result in a DoS condition.
  "
  impact 1.0
  tag cce: 'CCE-33807-9'
  describe 'Security Policy SeLockMemoryPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeLockMemoryPrivilege) }
    it { should be_empty }
  end
end

control '2.2.28_L1_Ensure_Log_on_as_a_batch_job_is_set_to_Administrators' do
  title "(L1) Ensure 'Log on as a batch job' is set to 'Administrators'"
  desc  "
    This policy setting allows users to dynamically load a new device driver on a system. An attacker could potentially use this capability to install malicious code that appears to be a device driver. This user right is required for users to add local printers or printer drivers in Windows Vista.

    The recommended state for this setting is: Administrators.

    Rationale: Device drivers run as highly privileged code. A user who has the Load and unload device drivers user right could unintentionally install malicious code that masquerades as a device driver. Administrators should exercise greater care and install only drivers with verified digital signatures.
  "
  impact 1.0
  tag cce: 'CCE-34903-5'
  describe 'Security Policy SeBatchLogonRight' do
    subject { Array(security_policy(translate_sid: true).SeBatchLogonRight) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.29_L2_Configure_Log_on_as_as_a_service' do
  title "(L2) Configure 'Log on as a service'"
  desc  "
    This policy setting allows users to dynamically load a new device driver on a system. An attacker could potentially use this capability to install malicious code that appears to be a device driver. This user right is required for users to add local printers or printer drivers in Windows Vista.

    The recommended state for this setting is: Administrators.

    Rationale: Device drivers run as highly privileged code. A user who has the Load and unload device drivers user right could unintentionally install malicious code that masquerades as a device driver. Administrators should exercise greater care and install only drivers with verified digital signatures.
  "
  impact 1.0
  tag cce: 'CCE-34903-5'
  if powershell('(Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-All -Online).State').stdout.strip == 'Enabled'
    describe 'Security Policy SeServiceLogonRight' do
      subject { Array(security_policy(translate_sid: true).SeServiceLogonRight) }
      it { should match_array ['BUILTIN\\Administrators', 'NT VIRTUAL MACHINE\\Virtual Machines'] }
    end
  else
    describe 'Security Policy SeServiceLogonRight' do
      subject { Array(security_policy(translate_sid: true).SeServiceLogonRight) }
      it { should match_array ['BUILTIN\\Administrators'] }
    end
  end
end

control '2.2.30_L1_Ensure_Manage_auditing_and_security_log_is_set_to_Administrators' do
  title "(L1) Ensure 'Manage auditing and security log' is set to 'Administrators'"
  desc  "
    This policy setting determines which users can change the auditing options for files and directories and clear the Security log.

    The recommended state for this setting is: Administrators.

    Rationale: The ability to manage the Security event log is a powerful user right and it should be closely guarded. Anyone with this user right can clear the Security log to erase important evidence of unauthorized activity.
  "
  impact 1.0
  tag cce: 'CCE-35275-7'
  describe 'Security Policy SeSecurityPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeSecurityPrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.31_L1_Ensure_Modify_an_object_label_is_set_to_No_One' do
  title "(L1) Ensure 'Modify an object label' is set to 'No One'"
  desc  "
    This privilege determines which user accounts can modify the integrity label of objects, such as files, registry keys, or processes owned by other users. Processes running under a user account can modify the label of an object owned by that user to a lower level without this privilege.

    The recommended state for this setting is: No One.

    Rationale: By modifying the integrity label of an object owned by another user a malicious user may cause them to execute code at a higher level of privilege than intended.
  "
  impact 1.0
  tag cce: 'CCE-34913-4'
  describe 'Security Policy SeRelabelPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeRelabelPrivilege) }
    it { should be_empty }
  end
end

control '2.2.32_L1_Ensure_Modify_firmware_environment_values_is_set_to_Administrators' do
  title "(L1) Ensure 'Modify firmware environment values' is set to 'Administrators'"
  desc  "
    This policy setting allows users to configure the system-wide environment variables that affect hardware configuration. This information is typically stored in the Last Known Good Configuration. Modification of these values and could lead to a hardware failure that would result in a denial of service condition.

    The recommended state for this setting is: Administrators.

    Rationale: Anyone who is assigned the Modify firmware environment values user right could configure the settings of a hardware component to cause it to fail, which could lead to data corruption or a DoS condition.
  "
  impact 1.0
  tag cce: 'CCE-35183-3'
  describe 'Security Policy SeSystemEnvironmentPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeSystemEnvironmentPrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.33_L1_Ensure_Perform_volume_maintenance_tasks_is_set_to_Administrators' do
  title "(L1) Ensure 'Perform volume maintenance tasks' is set to 'Administrators'"
  desc  "
    This policy setting allows users to manage the system's volume or disk configuration, which could allow a user to delete a volume and cause data loss as well as a denial-of-service condition.

    The recommended state for this setting is: Administrators.

    Rationale: A user who is assigned the Perform volume maintenance tasks user right could delete a volume, which could result in the loss of data or a DoS condition.
  "
  impact 1.0
  tag cce: 'CCE-35369-8'
  describe 'Security Policy SeManageVolumePrivilege' do
    subject { Array(security_policy(translate_sid: true).SeManageVolumePrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.34_L1_Ensure_Profile_single_process_is_set_to_Administrators' do
  title "(L1) Ensure 'Profile single process' is set to 'Administrators'"
  desc  "
    This policy setting determines which users can use tools to monitor the performance of non-system processes. Typically, you do not need to configure this user right to use the Microsoft Management Console (MMC) Performance snap-in. However, you do need this user right if System Monitor is configured to collect data using Windows Management Instrumentation (WMI). Restricting the Profile single process user right prevents intruders from gaining additional information that could be used to mount an attack on the system.

    The recommended state for this setting is: Administrators.

    Rationale: The Profile single process user right presents a moderate vulnerability. An attacker with this user right could monitor a computer's performance to help identify critical processes that they might wish to attack directly. The attacker may also be able to determine what processes run on the computer so that they could identify countermeasures that they may need to avoid, such as antivirus software, an intrusion-detection system, or which other users are logged on to a computer.
  "
  impact 1.0
  tag cce: 'CCE-35000-9'
  describe 'Security Policy SeProfileSingleProcessPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeProfileSingleProcessPrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.35_L1_Ensure_Profile_system_performance_is_set_to_Administrators_NT_SERVICEWdiServiceHost' do
  title "(L1) Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\\WdiServiceHost'"
  desc  "
    This policy setting allows users to use tools to view the performance of different system processes, which could be abused to allow attackers to determine a system's active processes and provide insight into the potential attack surface of the computer.

    The recommended state for this setting is: Administrators, NT SERVICE\\WdiServiceHost.

    Rationale: The Profile system performance user right poses a moderate vulnerability. Attackers with this user right could monitor a computer's performance to help identify critical processes that they might wish to attack directly. Attackers may also be able to determine what processes are active on the computer so that they could identify countermeasures that they may need to avoid, such as antivirus software or an intrusion detection system.
  "
  impact 1.0
  tag cce: 'CCE-35001-7'
  describe 'Security Policy SeSystemProfilePrivilege' do
    subject { Array(security_policy(translate_sid: true).SeSystemProfilePrivilege) }
    it { should match_array ['BUILTIN\\Administrators', 'NT SERVICE\\WdiServiceHost'] }
  end
end

control '2.2.36_L1_Ensure_Replace_a_process_level_token_is_set_to_LOCAL_SERVICE_NETWORK_SERVICE' do
  title "(L1) Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE'"
  desc  "
    This policy setting allows one process or service to start another service or process with a different security access token, which can be used to modify the security access token of that sub-process and result in the escalation of privileges.

    The recommended state for this setting is: LOCAL SERVICE, NETWORK SERVICE.

    Rationale: User with the Replace a process level token privilege are able to start processes as other users whose credentials they know. They could use this method to hide their unauthorized actions on the computer. (On Windows 2000-based computers, use of the Replace a process level token user right also requires the user to have the Adjust memory quotas for a process user right that is discussed earlier in this section.)
  "
  impact 1.0
  tag cce: 'CCE-35003-3'
  describe 'Security Policy SeAssignPrimaryTokenPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeAssignPrimaryTokenPrivilege) }
    it { should match_array ['NT AUTHORITY\\LOCAL SERVICE', 'NT AUTHORITY\\NETWORK SERVICE'] }
  end
end

control '2.2.37_L1_Ensure_Restore_files_and_directories_is_set_to_Administrators' do
  title "(L1) Ensure 'Restore files and directories' is set to 'Administrators'"
  desc  "
    This policy setting determines which users can bypass file, directory, registry, and other persistent object permissions when restoring backed up files and directories on computers that run Windows Vista in your environment. This user right also determines which users can set valid security principals as object owners; it is similar to the Back up files and directories user right.

    The recommended state for this setting is: Administrators.

    Rationale: An attacker with the Restore files and directories user right could restore sensitive data to a computer and overwrite data that is more recent, which could lead to loss of important data, data corruption, or a denial of service. Attackers could overwrite executable files that are used by legitimate administrators or system services with versions that include malicious software to grant themselves elevated privileges, compromise data, or install backdoors for continued access to the computer.

    **Note:** Even if the following countermeasure is configured, an attacker could still restore data to a computer in a domain that is controlled by the attacker. Therefore, it is critical that organizations carefully protect the media that are used to back up data.
  "
  impact 1.0
  tag cce: 'CCE-35067-8'
  describe 'Security Policy SeRestorePrivilege' do
    subject { Array(security_policy(translate_sid: true).SeRestorePrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.2.38_L1_Ensure_Shut_down_the_system_is_set_to_Administrators_Users' do
  title "(L1) Ensure 'Shut down the system' is set to 'Administrators, Users'"
  desc  "
    This policy setting determines which users who are logged on locally to the computers in your environment can shut down the operating system with the Shut Down command. Misuse of this user right can result in a denial of service condition.

    The recommended state for this setting is: Administrators, Users.

    Rationale: The ability to shut down a workstation should be available generally to Administrators and authorized Users of that workstation, but not permitted for guests or unauthorized users - in order to prevent a Denial of Service attack.
  "
  impact 1.0
  tag cce: 'CCE-35004-1'
  describe 'Security Policy SeShutdownPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeShutdownPrivilege) }
    it { should match_array ['BUILTIN\\Administrators', 'BUILTIN\\Users'] }
  end
end

control '2.2.39_L1_Ensure_Take_ownership_of_files_or_other_objects_is_set_to_Administrators' do
  title "(L1) Ensure 'Take ownership of files or other objects' is set to 'Administrators'"
  desc  "
    This policy setting allows users to take ownership of files, folders, registry keys, processes, or threads. This user right bypasses any permissions that are in place to protect objects to give ownership to the specified user.

    The recommended state for this setting is: Administrators.

    Rationale: Any users with the Take ownership of files or other objects user right can take control of any object, regardless of the permissions on that object, and then make any changes they wish to that object. Such changes could result in exposure of data, corruption of data, or a DoS condition.
  "
  impact 1.0
  tag cce: 'CCE-35009-0'
  describe 'Security Policy SeTakeOwnershipPrivilege' do
    subject { Array(security_policy(translate_sid: true).SeTakeOwnershipPrivilege) }
    it { should match_array ['BUILTIN\\Administrators'] }
  end
end

control '2.3.1.1_L1_Ensure_Accounts_Administrator_account_status_is_set_to_Disabled' do
  title "(L1) Ensure 'Accounts: Administrator account status' is set to 'Disabled'"
  desc  "
    This policy setting enables or disables the Administrator account during normal operation. When a computer is booted into safe mode, the Administrator account is always enabled, regardless of how this setting is configured. Note that this setting will have no impact when applied to the domain controller organizational unit via group policy because domain controllers have no local account database. It can be configured at the domain level via group policy, similar to account lockout and password policy settings.

    The recommended state for this setting is: Disabled.

    Rationale: In some organizations, it can be a daunting management challenge to maintain a regular schedule for periodic password changes for local accounts. Therefore, you may want to disable the built-in Administrator account instead of relying on regular password changes to protect it from attack. Another reason to disable this built-in account is that it cannot be locked out no matter how many failed logons it accrues, which makes it a prime target for brute force attacks that attempt to guess passwords. Also, this account has a well-known security identifier (SID) and there are third-party tools that allow authentication by using the SID rather than the account name. This capability means that even if you rename the Administrator account, an attacker could launch a brute force attack by using the SID to log on.
  "
  impact 1.0
  tag cce: 'CCE-33511-7'
  machine_sid = powershell('"{0}-500" -f ((Get-LocalUser | Select-Object -First 1).SID).AccountDomainSID.ToString()').stdout.strip.gsub(/^S-[0-9]*-[0-9]*-[0-9]*-/, '').gsub(/-[0-9]+$/, '')
  user_sid = "S-1-5-21-#{machine_sid}-500"
  describe powershell("Get-LocalUser -SID '#{user_sid}' | Format-Table Enabled -HideTableHeaders").stdout.strip.upcase do
    it { should eq 'FALSE' }
  end
end

control '2.3.1.2_L1_Ensure_Accounts_Block_Microsoft_accounts_is_set_to_Users_cant_add_or_log_on_with_Microsoft_accounts' do
  title "(L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'"
  desc  "
    This policy setting prevents users from adding new Microsoft accounts on this computer.

    If you select the \"Users can't add Microsoft accounts\" option, users will not be able to create new Microsoft accounts on this computer, switch a local account to a Microsoft account, or connect a domain account to a Microsoft account. This is the preferred option if you need to limit the use of Microsoft accounts in your enterprise.

    If you select the \"Users can't add or log on with Microsoft accounts\" option, existing Microsoft account users will not be able to log on to Windows. Selecting this option might make it impossible for an existing administrator on this computer to log on and manage the system.

    If you disable or do not configure this policy (recommended), users will be able to use Microsoft accounts with Windows.

    The recommended state for this setting is: Users can't add or log on with Microsoft accounts.

    Rationale: Organizations that want to effectively implement identity management policies and maintain firm control of what accounts are used to log onto their computers will probably want to block Microsoft accounts. Organizations may also need to block Microsoft accounts in order to meet the requirements of compliance standards that apply to their information systems.
  "
  impact 1.0
  tag cce: 'CCE-35487-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'NoConnectedUser' }
    its('NoConnectedUser') { should cmp == 3 }
  end
end

control '2.3.1.3_L1_Ensure_Accounts_Guest_account_status_is_set_to_Disabled' do
  title "(L1) Ensure 'Accounts: Guest account status' is set to 'Disabled'"
  desc  "
    This policy setting determines whether the Guest account is enabled or disabled. The Guest account allows unauthenticated network users to gain access to the system. Note that this setting will have no impact when applied to the domain controller organizational unit via group policy because domain controllers have no local account database. It can be configured at the domain level via group policy, similar to account lockout and password policy settings.

    The recommended state for this setting is: Disabled.

    Rationale: The default Guest account allows unauthenticated network users to log on as Guest with no password. These unauthorized users could access any resources that are accessible to the Guest account over the network. This capability means that any network shares with permissions that allow access to the Guest account, the Guests group, or the Everyone group will be accessible over the network, which could lead to the exposure or corruption of data.
  "
  impact 1.0
  tag cce: 'CCE-33949-9'
  machine_sid = powershell('"{0}-500" -f ((Get-LocalUser | Select-Object -First 1).SID).AccountDomainSID.ToString()').stdout.strip.gsub(/^S-[0-9]*-[0-9]*-[0-9]*-/, '').gsub(/-[0-9]+$/, '')
  user_sid = "S-1-5-21-#{machine_sid}-501"
  describe powershell("Get-LocalUser -SID '#{user_sid}' | Format-Table Enabled -HideTableHeaders").stdout.strip.upcase do
    it { should eq 'FALSE' }
  end
end

control '2.3.1.4_L1_Ensure_Accounts_Limit_local_account_use_of_blank_passwords_to_console_logon_only_is_set_to_Enabled' do
  title "(L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'"
  desc  "
    This policy setting determines whether local accounts that are not password protected can be used to log on from locations other than the physical computer console. If you enable this policy setting, local accounts that have blank passwords will not be able to log on to the network from remote client computers. Such accounts will only be able to log on at the keyboard of the computer.

    The recommended state for this setting is: Enabled.

    Rationale: Blank passwords are a serious threat to computer security and should be forbidden through both organizational policy and suitable technical measures. In fact, the default settings for Active Directory domains require complex passwords of at least seven characters. However, if users with the ability to create new accounts bypass your domain-based password policies, they could create accounts with blank passwords. For example, a user could build a stand-alone computer, create one or more accounts with blank passwords, and then join the computer to the domain. The local accounts with blank passwords would still function. Anyone who knows the name of one of these unprotected accounts could then use it to log on.
  "
  impact 1.0
  tag cce: 'CCE-32929-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'LimitBlankPasswordUse' }
    its('LimitBlankPasswordUse') { should cmp == 1 }
  end
end

control '2.3.1.5_L1_Configure_Accounts_Rename_administrator_account' do
  title "(L1) Configure 'Accounts: Rename administrator account'"
  desc  "
    The built-in local administrator account is a well-known account name that attackers will target. It is recommended to choose another name for this account, and to avoid names that denote administrative or elevated access accounts. Be sure to also change the default description for the local administrator (through the Computer Management console).

    Rationale: The Administrator account exists on all computers that run the Windows 2000 or later operating systems. If you rename this account, it is slightly more difficult for unauthorized persons to guess this privileged user name and password combination.

    The built-in Administrator account cannot be locked out, regardless of how many times an attacker might use a bad password. This capability makes the Administrator account a popular target for brute force attacks that attempt to guess passwords. The value of this countermeasure is lessened because this account has a well-known SID, and there are third-party tools that allow authentication by using the SID rather than the account name. Therefore, even if you rename the Administrator account, an attacker could launch a brute force attack by using the SID to log on.
  "
  impact 1.0
  tag cce: 'CCE-33034-0'
  describe powershell("Get-WmiObject -Class win32_useraccount -filter \"Domain='$($env:ComputerName)' and name='Administrator'\"") do
    its('stdout') { should eq '' }
    its('exit_status') { should cmp 0 }
  end
end

control '2.3.1.6_L1_Configure_Accounts_Rename_guest_account' do
  title "(L1) Configure 'Accounts: Rename guest account'"
  desc  "
    The built-in local guest account is another well-known name to attackers. It is recommended to rename this account to something that does not indicate its purpose. Even if you disable this account, which is recommended, ensure that you rename it for added security.

    Rationale: The Guest account exists on all computers that run the Windows 2000 or later operating systems. If you rename this account. it is slightly more difficult for unauthorized persons to guess this privileged user name and password combination.
  "
  impact 1.0
  tag cce: 'CCE-35488-6'
  describe powershell("Get-WmiObject -Class win32_useraccount -filter \"Domain='$($env:ComputerName)' and name='Guest'\"") do
    its('stdout') { should eq '' }
    its('exit_status') { should cmp 0 }
  end
end

control '2.3.2.1_L1_Ensure_Audit_Force_audit_policy_subcategory_settings_Windows_Vista_or_later_to_override_audit_policy_category_settings_is_set_to_Enabled' do
  title "(L1) Ensure 'Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings' is set to 'Enabled'"
  desc  "
    This policy setting allows administrators to enable the more precise auditing capabilities present in Windows Vista.

    The Audit Policy settings available in Windows Server 2003 Active Directory do not yet contain settings for managing the new auditing subcategories. To properly apply the auditing policies prescribed in this baseline, the Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings setting needs to be configured to Enabled.

    The recommended state for this setting is: Enabled.

    Rationale: Prior to the introduction of auditing subcategories in Windows Vista, it was difficult to track events at a per-system or per-user level. The larger event categories created too many events and the key information that needed to be audited was difficult to find.
  "
  impact 1.0
  tag cce: 'CCE-35533-9'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'scenoapplylegacyauditpolicy' }
    its('scenoapplylegacyauditpolicy') { should cmp == 1 }
  end
end

control '2.3.2.2_L1_Ensure_Audit_Shut_down_system_immediately_if_unable_to_log_security_audits_is_set_to_Disabled' do
  title "(L1) Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled'"
  desc  "
    This policy setting determines whether the system shuts down if it is unable to log Security events. It is a requirement for Trusted Computer System Evaluation Criteria (TCSEC)-C2 and Common Criteria certification to prevent auditable events from occurring if the audit system is unable to log them. Microsoft has chosen to meet this requirement by halting the system and displaying a stop message if the auditing system experiences a failure. When this policy setting is enabled, the system will be shut down if a security audit cannot be logged for any reason.

    If the Audit: Shut down system immediately if unable to log security audits setting is enabled, unplanned system failures can occur. Therefore, this policy setting is configured to Not Defined for both of the environments that are discussed in this chapter.

    The recommended state for this setting is: Disabled.

    Rationale: If the computer is unable to record events to the Security log, critical evidence or important troubleshooting information may not be available for review after a security incident. Also, an attacker could potentially generate a large volume of Security log events to purposely force a computer shutdown.
  "
  impact 1.0
  tag cce: 'CCE-33046-4'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'crashonauditfail' }
    its('crashonauditfail') { should cmp == 0 }
  end
end

control '2.3.4.1_L1_Ensure_Devices_Allowed_to_format_and_eject_removable_media_is_set_to_Administrators_and_Interactive_Users' do
  title "(L1) Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators and Interactive Users'"
  desc  "
    This policy setting determines who is allowed to format and eject removable NTFS media. You can use this policy setting to prevent unauthorized users from removing data on one computer to access it on another computer on which they have local administrator privileges.

    The recommended state for this setting is: Administrators and Interactive Users.

    Rationale: Users may be able to move data on removable disks to a different computer where they have administrative privileges. The user could then take ownership of any file, grant themselves full control, and view or modify any file. The fact that most removable storage devices will eject media by pressing a mechanical button diminishes the advantage of this policy setting.
  "
  impact 1.0
  tag cce: 'CCE-34355-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
    it { should have_property 'AllocateDASD' }
    its('AllocateDASD') { should eq '2' }
  end
end

control '2.3.4.2_L1_Ensure_Devices_Prevent_users_from_installing_printer_drivers_is_set_to_Enabled' do
  title "(L1) Ensure 'Devices: Prevent users from installing printer drivers' is set to 'Enabled'"
  desc  "
    This policy setting determines who is allowed to format and eject removable NTFS media. You can use this policy setting to prevent unauthorized users from removing data on one computer to access it on another computer on which they have local administrator privileges.

    The recommended state for this setting is: Administrators and Interactive Users.

    Rationale: Users may be able to move data on removable disks to a different computer where they have administrative privileges. The user could then take ownership of any file, grant themselves full control, and view or modify any file. The fact that most removable storage devices will eject media by pressing a mechanical button diminishes the advantage of this policy setting.
  "
  impact 1.0
  tag cce: 'CCE-34355-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Print\\Providers\\LanMan Print Services\\Servers') do
    it { should have_property 'AddPrinterDrivers' }
    its('AddPrinterDrivers') { should eq 1 }
  end
end

control '2.3.6.1_L1_Ensure_Domain_member_Digitally_encrypt_or_sign_secure_channel_data_always_is_set_to_Enabled' do
  title "(L1) Ensure 'Domain member: Digitally encrypt or sign secure channel data (always)' is set to 'Enabled'"
  desc  "
    This policy setting determines whether all secure channel traffic that is initiated by the domain member must be signed or encrypted. If a system is set to always encrypt or sign secure channel data, it cannot establish a secure channel with a domain controller that is not capable of signing or encrypting all secure channel traffic, because all secure channel data must be signed and encrypted.

    The recommended state for this setting is: Enabled.

    Rationale: When a computer joins a domain, a computer account is created. After it joins the domain, the computer uses the password for that account to create a secure channel with the domain controller for its domain every time that it restarts. Requests that are sent on the secure channel are authenticated#x2014;and sensitive information such as passwords are encrypted#x2014;but the channel is not integrity-checked, and not all information is encrypted. If a computer is configured to always encrypt or sign secure channel data but the domain controller cannot sign or encrypt any portion of the secure channel data, the computer and domain controller cannot establish a secure channel. If the computer is configured to encrypt or sign secure channel data when possible, a secure channel can be established, but the level of encryption and signing is negotiated.
  "
  impact 1.0
  tag cce: 'CCE-34892-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    it { should have_property 'requiresignorseal' }
    its('RequireSignOrSeal') { should cmp == 1 }
  end
end

control '2.3.6.2_L1_Ensure_Domain_member_Digitally_encrypt_secure_channel_data_when_possible_is_set_to_Enabled' do
  title "(L1) Ensure 'Domain member: Digitally encrypt secure channel data (when possible)' is set to 'Enabled'"
  desc  "
    This policy setting determines whether a domain member should attempt to negotiate encryption for all secure channel traffic that it initiates. If you enable this policy setting, the domain member will request encryption of all secure channel traffic. If you disable this policy setting, the domain member will be prevented from negotiating secure channel encryption.

    The recommended state for this setting is: Enabled.

    Rationale: When a Windows Server 2003, Windows XP, Windows 2000, or Windows NT computer joins a domain, a computer account is created. After it joins the domain, the computer uses the password for that account to create a secure channel with the domain controller for its domain every time that it restarts. Requests that are sent on the secure channel are authenticated#x2014;and sensitive information such as passwords are encrypted#x2014;but the channel is not integrity-checked, and not all information is encrypted. If a computer is configured to always encrypt or sign secure channel data but the domain controller cannot sign or encrypt any portion of the secure channel data, the computer and domain controller cannot establish a secure channel. If the computer is configured to encrypt or sign secure channel data when possible, a secure channel can be established, but the level of encryption and signing is negotiated.
  "
  impact 1.0
  tag cce: 'CCE-35273-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    it { should have_property 'sealsecurechannel' }
    its('SealSecureChannel') { should cmp == 1 }
  end
end

control '2.3.6.3_L1_Ensure_Domain_member_Digitally_sign_secure_channel_data_when_possible_is_set_to_Enabled' do
  title "(L1) Ensure 'Domain member: Digitally sign secure channel data (when possible)' is set to 'Enabled'"
  desc  "
    This policy setting determines whether a domain member should attempt to negotiate whether all secure channel traffic that it initiates must be digitally signed. Digital signatures protect the traffic from being modified by anyone who captures the data as it traverses the network.

    The recommended state for this setting is: Enabled.

    Rationale: When a computer joins a domain, a computer account is created. After it joins the domain, the computer uses the password for that account to create a secure channel with the domain controller for its domain every time that it restarts. Requests that are sent on the secure channel are authenticated#x2014;and sensitive information such as passwords are encrypted#x2014;but the channel is not integrity-checked, and not all information is encrypted. If a computer is configured to always encrypt or sign secure channel data but the domain controller cannot sign or encrypt any portion of the secure channel data, the computer and domain controller cannot establish a secure channel. If the computer is configured to encrypt or sign secure channel data when possible, a secure channel can be established, but the level of encryption and signing is negotiated.
  "
  impact 1.0
  tag cce: 'CCE-34893-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    it { should have_property 'SignSecureChannel' }
    its('SignSecureChannel') { should cmp == 1 }
  end
end

control '2.3.6.4_L1_Ensure_Domain_member_Disable_machine_account_password_changes_is_set_to_Disabled' do
  title "(L1) Ensure 'Domain member: Disable machine account password changes' is set to 'Disabled'"
  desc  "
    This policy setting determines whether a domain member can periodically change its computer account password. If you enable this policy setting, the domain member will be prevented from changing its computer account password. If you disable this policy setting, the domain member can change its computer account password as specified by the Domain Member: Maximum machine account password age setting, which by default is every 30 days. Computers that cannot automatically change their account passwords are potentially vulnerable, because an attacker might be able to determine the password for the system's domain account.

    The recommended state for this setting is: Disabled.

    Rationale: The default configuration for Windows Server 2003-based computers that belong to a domain is that they are automatically required to change the passwords for their accounts every 30 days. If you disable this policy setting, computers that run Windows Server 2003 will retain the same passwords as their computer accounts. Computers that are no longer able to automatically change their account password are at risk from an attacker who could determine the password for the computer's domain account.
  "
  impact 1.0
  tag cce: 'CCE-34986-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    it { should have_property 'DisablePasswordChange' }
    its('DisablePasswordChange') { should cmp == 0 }
  end
end

control '2.3.6.5_L1_Ensure_Domain_member_Maximum_machine_account_password_age_is_set_to_30_or_fewer_days_but_not_0' do
  title "(L1) Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0'"
  desc  "
    This policy setting determines the maximum allowable age for a computer account password. By default, domain members automatically change their domain passwords every 30 days. If you increase this interval significantly so that the computers no longer change their passwords, an attacker would have more time to undertake a brute force attack against one of the computer accounts.

    The recommended state for this setting is: 30 or fewer days, but not 0.

    **Note:** A value of 0 does not conform to the benchmark as it disables maximum password age.

    Rationale: In Active Directory-based domains, each computer has an account and password just like every user. By default, the domain members automatically change their domain password every 30 days. If you increase this interval significantly, or set it to 0 so that the computers no longer change their passwords, an attacker will have more time to undertake a brute force attack to guess the password of one or more computer accounts.
  "
  impact 1.0
  tag cce: 'CCE-34894-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    it { should have_property 'MaximumPasswordAge' }
    its('MaximumPasswordAge') { should cmp > 0 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    it { should have_property 'MaximumPasswordAge' }
    its('MaximumPasswordAge') { should cmp <= 30 }
  end
end

control '2.3.6.6_L1_Ensure_Domain_member_Require_strong_Windows_2000_or_later_session_key_is_set_to_Enabled' do
  title "(L1) Ensure 'Domain member: Require strong (Windows 2000 or later) session key' is set to 'Enabled'"
  desc  "
    When this policy setting is enabled, a secure channel can only be established with domain controllers that are capable of encrypting secure channel data with a strong (128-bit) session key.

    To enable this policy setting, all domain controllers in the domain must be able to encrypt secure channel data with a strong key, which means all domain controllers must be running Microsoft Windows 2000 or later.

    The recommended state for this setting is: Enabled.

    Rationale: Session keys that are used to establish secure channel communications between domain controllers and member computers are much stronger in Windows 2000 than they were in previous Microsoft operating systems. Whenever possible, you should take advantage of these stronger session keys to help protect secure channel communications from attacks that attempt to hijack network sessions and eavesdropping. (Eavesdropping is a form of hacking in which network data is read or altered in transit. The data can be modified to hide or change the sender, or be redirected.)
  "
  impact 1.0
  tag cce: 'CCE-35177-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    it { should have_property 'RequireStrongKey' }
    its('RequireStrongKey') { should cmp == 1 }
  end
end

control '2.3.7.1_L1_Ensure_Interactive_logon_Do_not_require_CTRLALTDEL_is_set_to_Disabled' do
  title "(L1) Ensure 'Interactive logon: Do not require CTRL+ALT+DEL' is set to 'Disabled'"
  desc  "
    This policy setting determines whether users must press CTRL+ALT+DEL before they log on. If you enable this policy setting, users can log on without this key combination. If you disable this policy setting, users must press CTRL+ALT+DEL before they log on to Windows unless they use a smart card for Windows logon. A smart card is a tamper-proof device that stores security information.

    The recommended state for this setting is: Disabled.

    Rationale: Microsoft developed this feature to make it easier for users with certain types of physical impairments to log on to computers that run Windows. If users are not required to press CTRL+ALT+DEL, they are susceptible to attacks that attempt to intercept their passwords. If CTRL+ALT+DEL is required before logon, user passwords are communicated by means of a trusted path.

    An attacker could install a Trojan horse program that looks like the standard Windows logon dialog box and capture the user's password. The attacker would then be able to log on to the compromised account with whatever level of privilege that user has.
  "
  impact 1.0
  tag cce: 'CCE-35099-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'DisableCAD' }
    its('DisableCAD') { should cmp == 0 }
  end
end

control '2.3.7.2_L1_Ensure_Interactive_logon_Do_not_display_last_user_name_is_set_to_Enabled' do
  title "(L1) Ensure 'Interactive logon: Do not display last user name' is set to 'Enabled'"
  desc  "
    This policy setting determines whether the account name of the last user to log on to the client computers in your organization will be displayed in each computer's respective Windows logon screen. Enable this policy setting to prevent intruders from collecting account names visually from the screens of desktop or laptop computers in your organization.

    The recommended state for this setting is: Enabled.

    Rationale: An attacker with access to the console (for example, someone with physical access or someone who is able to connect to the server through Terminal Services) could view the name of the last user who logged on to the server. The attacker could then try to guess the password, use a dictionary, or use a brute-force attack to try and log on.
  "
  impact 1.0
  tag cce: 'CCE-34898-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'DontDisplayLastUserName' }
    its('DontDisplayLastUserName') { should cmp == 1 }
  end
end

control '2.3.7.3_L1_Ensure_Interactive_logon_Machine_account_lockout_threshold_is_set_to_10_or_fewer_invalid_logon_attempts_but_not_0' do
  title '(L1) Ensure L1 Ensure Interactive logon Machine account lockout threshold is set to 10 or fewer invalid logon attempts but not 0'
  desc  "
    This policy setting determines whether the account name of the last user to log on to the client computers in your organization will be displayed in each computer's respective Windows logon screen. Enable this policy setting to prevent intruders from collecting account names visually from the screens of desktop or laptop computers in your organization.

    The recommended state for this setting is: Enabled.

    Rationale: An attacker with access to the console (for example, someone with physical access or someone who is able to connect to the server through Terminal Services) could view the name of the last user who logged on to the server. The attacker could then try to guess the password, use a dictionary, or use a brute-force attack to try and log on.
  "
  impact 1.0
  tag cce: 'CCE-34898-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'MaxDevicePasswordFailedAttempts' }
    its('MaxDevicePasswordFailedAttempts') { should cmp > 0 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'MaxDevicePasswordFailedAttempts' }
    its('MaxDevicePasswordFailedAttempts') { should cmp <= 10 }
  end
end

control '2.3.7.4_L1_Ensure_Interactive_logon_Machine_inactivity_limit_is_set_to_900_or_fewer_seconds_but_not_0' do
  title '(L1) Ensure Interactive logon: Machine inactivity limit is set to 900 or fewer second(s), but not 0'
  desc  "
    Windows notices inactivity of a logon session, and if the amount of inactive time exceeds the inactivity limit, then the screen saver will run, locking the session.

    The recommended state for this setting is: 900 or fewer second(s), but not 0.

    **Note:** A value of 0 does not conform to the benchmark as it disables the machine inactivity limit.

    Rationale: If a user forgets to lock their computer when they walk away its possible that a passerby will hijack it.
  "
  impact 1.0
  tag cce: 'CCE-34900-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'InactivityTimeoutSecs' }
    its('InactivityTimeoutSecs') { should cmp <= 900 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'InactivityTimeoutSecs' }
    its('InactivityTimeoutSecs') { should cmp != 0 }
  end
end

control '2.3.7.5_L1_Configure_Interactive_logon_Message_text_for_users_attempting_to_log_on' do
  title "(L1) Configure 'Interactive logon: Message text for users attempting to log on'"
  desc  "
    This policy setting specifies a text message that displays to users when they log on. Set the following group policy to a value that is consistent with the security and operational requirements of your organization.

    Rationale: Displaying a warning message before logon may help prevent an attack by warning the attacker about the consequences of their misconduct before it happens. It may also help to reinforce corporate policy by notifying employees of the appropriate policy during the logon process. This text is often used for legal reasons#x2014;for example, to warn users about the ramifications of misusing company information or to warn them that their actions may be audited.

    **Note:** Any warning that you display should first be approved by your organization's legal and human resources representatives.
  "
  impact 1.0
  tag cce: 'CCE-35064-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'LegalNoticeText' }
    its('LegalNoticeText') { should match(/[a-zA-Z]/) }
  end
end

control '2.3.7.6_L1_Configure_Interactive_logon_Message_title_for_users_attempting_to_log_on' do
  title "(L1) Configure 'Interactive logon: Message title for users attempting to log on'"
  desc  "
    This policy setting specifies the text displayed in the title bar of the window that users see when they log on to the system. Configure this setting in a manner that is consistent with the security and operational requirements of your organization.

    Rationale: Displaying a warning message before logon may help prevent an attack by warning the attacker about the consequences of their misconduct before it happens. It may also help to reinforce corporate policy by notifying employees of the appropriate policy during the logon process.
  "
  impact 1.0
  tag cce: 'CCE-35179-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'LegalNoticeCaption' }
    its('LegalNoticeCaption') { should match(/[a-zA-Z]/) }
  end
end

control '2.3.7.8_L1_Ensure_Interactive_logon_Prompt_user_to_change_password_before_expiration_is_set_to_between_5_and_14_days' do
  title "(L1) Ensure 'Interactive logon: Prompt user to change password before expiration' is set to 'between 5 and 14 days'"
  desc  "
    This policy setting determines how far in advance users are warned that their password will expire. It is recommended that you configure this policy setting to at least 5 days but no more than 14 days to sufficiently warn users when their passwords will expire.

    The recommended state for this setting is: between 5 and 14 days.

    Rationale: Users will need to be warned that their passwords are going to expire, or they may inadvertently be locked out of the computer when their passwords expire. This condition could lead to confusion for users who access the network locally, or make it impossible for users to access your organization's network through dial-up or virtual private network (VPN) connections.
  "
  impact 1.0
  tag cce: 'CCE-35274-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
    it { should have_property 'PasswordExpiryWarning' }
    its('PasswordExpiryWarning') { should cmp <= 14 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
    it { should have_property 'PasswordExpiryWarning' }
    its('PasswordExpiryWarning') { should cmp >= 5 }
  end
end

control '2.3.7.9_L1_Ensure_Interactive_logon_Smart_card_removal_behavior_is_set_to_Lock_Workstation_or_higher' do
  title "(L1) Ensure 'Interactive logon: Smart card removal behavior' is set to 'Lock Workstation' or higher"
  desc  "
    This policy setting determines what happens when the smart card for a logged-on user is removed from the smart card reader.

    The recommended state for this setting is: Lock Workstation. Configuring this setting to Force Logoff or Disconnect if a Remote Desktop Services session also conforms with the benchmark.

    Rationale: Users sometimes forget to lock their workstations when they are away from them, allowing the possibility for malicious users to access their computers. If smart cards are used for authentication, the computer should automatically lock itself when the card is removed to ensure that only the user with the smart card is accessing resources using those credentials.
  "
  impact 1.0
  tag cce: 'CCE-34988-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
    it { should have_property 'ScRemoveOption' }
    its('ScRemoveOption') { should match(/^(1|2|3)$/) }
  end
end

control '2.3.8.1_L1_Ensure_Microsoft_network_client_Digitally_sign_communications_always_is_set_to_Enabled' do
  title "(L1) Ensure 'Microsoft network client: Digitally sign communications (always)' is set to 'Enabled'"
  desc  "
    This policy setting determines whether packet signing is required by the SMB client component. If you enable this policy setting, the Microsoft network client computer cannot communicate with a Microsoft network server unless that server agrees to sign SMB packets. In mixed environments with legacy client computers, set this option to Disabled because these computers will not be able to authenticate or gain access to domain controllers. However, you can use this policy setting in Windows 2000 or later environments.

    **Note:** When Windows Vista-based computers have this policy setting enabled and they connect to file or print shares on remote servers, it is important that the setting is synchronized with its companion setting, **Microsoft network server: Digitally sign communications (always)**, on those servers. For more information about these settings, see the \"Microsoft network client and server: Digitally sign communications (four related settings)\" section in Chapter 5 of the Threats and Countermeasures guide.

    The recommended state for this setting is: Enabled.

    Rationale: Session hijacking uses tools that allow attackers who have access to the same network as the client or server to interrupt, end, or steal a session in progress. Attackers can potentially intercept and modify unsigned SMB packets and then modify the traffic and forward it so that the server might perform undesirable actions. Alternatively, the attacker could pose as the server or client after legitimate authentication and gain unauthorized access to data.

    SMB is the resource sharing protocol that is supported by many Windows operating systems. It is the basis of NetBIOS and many other protocols. SMB signatures authenticate both users and the servers that host the data. If either side fails the authentication process, data transmission will not take place.
  "
  impact 1.0
  tag cce: 'CCE-35222-9'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters') do
    it { should have_property 'RequireSecuritySignature' }
    its('RequireSecuritySignature') { should cmp == 1 }
  end
end

control '2.3.8.2_L1_Ensure_Microsoft_network_client_Digitally_sign_communications_if_server_agrees_is_set_to_Enabled' do
  title "(L1) Ensure 'Microsoft network client: Digitally sign communications (if server agrees)' is set to 'Enabled'"
  desc  "
    This policy setting determines whether the SMB client will attempt to negotiate SMB packet signing. The implementation of digital signing in Windows-based networks helps to prevent sessions from being hijacked. If you enable this policy setting, the Microsoft network client will use signing only if the server with which it communicates accepts digitally signed communication.

    **Note:** Enabling this policy setting on SMB clients on your network makes them fully effective for packet signing with all clients and servers in your environment.

    The recommended state for this setting is: Enabled.

    Rationale: Session hijacking uses tools that allow attackers who have access to the same network as the client or server to interrupt, end, or steal a session in progress. Attackers can potentially intercept and modify unsigned SMB packets and then modify the traffic and forward it so that the server might perform undesirable actions. Alternatively, the attacker could pose as the server or client after legitimate authentication and gain unauthorized access to data.

    SMB is the resource sharing protocol that is supported by many Windows operating systems. It is the basis of NetBIOS and many other protocols. SMB signatures authenticate both users and the servers that host the data. If either side fails the authentication process, data transmission will not take place.
  "
  impact 1.0
  tag cce: 'CCE-34908-4'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters') do
    it { should have_property 'EnableSecuritySignature' }
    its('EnableSecuritySignature') { should cmp == 1 }
  end
end

control '2.3.8.3_L1_Ensure_Microsoft_network_client_Send_unencrypted_password_to_third-party_SMB_servers_is_set_to_Disabled' do
  title "(L1) Ensure 'Microsoft network client: Send unencrypted password to third-party SMB servers' is set to 'Disabled'"
  desc  "
    Disable this policy setting to prevent the SMB redirector from sending plaintext passwords during authentication to third-party SMB servers that do not support password encryption. It is recommended that you disable this policy setting unless there is a strong business case to enable it. If this policy setting is enabled, unencrypted passwords will be allowed across the network.

    The recommended state for this setting is: Disabled.

    Rationale: If you enable this policy setting, the server can transmit passwords in plaintext across the network to other computers that offer SMB services. These other computers may not use any of the SMB security mechanisms that are included with Windows Server 2003.
  "
  impact 1.0
  tag cce: 'CCE-33717-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters') do
    it { should have_property 'EnablePlainTextPassword' }
    its('EnablePlainTextPassword') { should cmp == 0 }
  end
end

control '2.3.9.1_L1_Ensure_Microsoft_network_server_Amount_of_idle_time_required_before_suspending_session_is_set_to_15_or_fewer_minutes_but_not_0' do
  title "(L1) Ensure 'Microsoft network server: Amount of idle time required before suspending session' is set to '15 or fewer minute(s), but not 0'"
  desc  "
    This policy setting allows you to specify the amount of continuous idle time that must pass in an SMB session before the session is suspended because of inactivity. Administrators can use this policy setting to control when a computer suspends an inactive SMB session. If client activity resumes, the session is automatically reestablished.

    A value of 0 appears to allow sessions to persist indefinitely. The maximum value is 99999, which is over 69 days; in effect, this value disables the setting.

    The recommended state for this setting is: 15 or fewer minute(s), but not 0.

    Rationale: Each SMB session consumes server resources, and numerous null sessions will slow the server or possibly cause it to fail. An attacker could repeatedly establish SMB sessions until the server's SMB services become slow or unresponsive.
  "
  impact 1.0
  tag cce: 'CCE-34909-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    it { should have_property 'AutoDisconnect' }
    its('AutoDisconnect') { should cmp <= 15 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    it { should have_property 'AutoDisconnect' }
    its('AutoDisconnect') { should cmp != 0 }
  end
end

control '2.3.9.2_L1_Ensure_Microsoft_network_server_Digitally_sign_communications_always_is_set_to_Enabled' do
  title "(L1) Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled'"
  desc  "
    This policy setting determines if the server side SMB service is required to perform SMB packet signing. Enable this policy setting in a mixed environment to prevent downstream clients from using the workstation as a network server.

    The recommended state for this setting is: Enabled.

    Rationale: Session hijacking uses tools that allow attackers who have access to the same network as the client or server to interrupt, end, or steal a session in progress. Attackers can potentially intercept and modify unsigned SMB packets and then modify the traffic and forward it so that the server might perform undesirable actions. Alternatively, the attacker could pose as the server or client after legitimate authentication and gain unauthorized access to data.

    SMB is the resource sharing protocol that is supported by many Windows operating systems. It is the basis of NetBIOS and many other protocols. SMB signatures authenticate both users and the servers that host the data. If either side fails the authentication process, data transmission will not take place.
  "
  impact 1.0
  tag cce: 'CCE-35065-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    it { should have_property 'RequireSecuritySignature' }
    its('RequireSecuritySignature') { should cmp == 1 }
  end
end

control '2.3.9.3_L1_Ensure_Microsoft_network_server_Digitally_sign_communications_if_client_agrees_is_set_to_Enabled' do
  title "(L1) Ensure 'Microsoft network server: Digitally sign communications (if client agrees)' is set to 'Enabled'"
  desc  "
    This policy setting determines if the server side SMB service is able to sign SMB packets if it is requested to do so by a client that attempts to establish a connection. If no signing request comes from the client, a connection will be allowed without a signature if the **Microsoft network server: Digitally sign communications (always)** setting is not enabled.

    **Note:** Enable this policy setting on SMB clients on your network to make them fully effective for packet signing with all clients and servers in your environment.

    The recommended state for this setting is: Enabled.

    Rationale: Session hijacking uses tools that allow attackers who have access to the same network as the client or server to interrupt, end, or steal a session in progress. Attackers can potentially intercept and modify unsigned SMB packets and then modify the traffic and forward it so that the server might perform undesirable actions. Alternatively, the attacker could pose as the server or client after legitimate authentication and gain unauthorized access to data.

    SMB is the resource sharing protocol that is supported by many Windows operating systems. It is the basis of NetBIOS and many other protocols. SMB signatures authenticate both users and the servers that host the data. If either side fails the authentication process, data transmission will not take place.
  "
  impact 1.0
  tag cce: 'CCE-35182-5'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    it { should have_property 'EnableSecuritySignature' }
    its('EnableSecuritySignature') { should cmp == 1 }
  end
end

control '2.3.9.4_L1_Ensure_Microsoft_network_server_Disconnect_clients_when_logon_hours_expire_is_set_to_Enabled' do
  title "(L1) Ensure 'Microsoft network server: Disconnect clients when logon hours expire' is set to 'Enabled'"
  desc  "
    This policy setting determines whether to disconnect users who are connected to the local computer outside their user account's valid logon hours. It affects the SMB component. If you enable this policy setting, client sessions with the SMB service will be forcibly disconnected when the client's logon hours expire. If you disable this policy setting, established client sessions will be maintained after the client's logon hours expire. If you enable this policy setting you should also enable **Network security: Force logoff when logon hours expire**.

    If your organization configures logon hours for users, this policy setting is necessary to ensure they are effective.

    The recommended state for this setting is: Enabled.

    Rationale: If your organization configures logon hours for users, then it makes sense to enable this policy setting. Otherwise, users who should not have access to network resources outside of their logon hours may actually be able to continue to use those resources with sessions that were established during allowed hours.
  "
  impact 1.0
  tag cce: 'CCE-34911-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    it { should have_property 'enableforcedlogoff' }
    its('EnableForcedLogoff') { should cmp == 1 }
  end
end

control '2.3.9.5_L1_Ensure_Microsoft_network_server_Server_SPN_target_name_validation_level_is_set_to_Accept_if_provided_by_client_or_higher' do
  title "(L1) Ensure 'Microsoft network server: Server SPN target name validation level' is set to 'Accept if provided by client' or higher"
  desc  "
    This policy setting controls the level of validation a computer with shared folders or printers (the server) performs on the service principal name (SPN) that is provided by the client computer when it establishes a session using the server message block (SMB) protocol.

    The server message block (SMB) protocol provides the basis for file and print sharing and other networking operations, such as remote Windows administration. The SMB protocol supports validating the SMB server service principal name (SPN) within the authentication blob provided by a SMB client to prevent a class of attacks against SMB servers referred to as SMB relay attacks. This setting will affect both SMB1 and SMB2.

    This security setting determines the level of validation a SMB server performs on the service principal name (SPN) provided by the SMB client when trying to establish a session to an SMB server.

    The recommended state for this setting is: Accept if provided by client. Configuring this setting to Required from client also conforms with the benchmark.

    Rationale: The identity of a computer can be spoofed to gain unauthorized access to network resources.
  "
  impact 1.0
  tag cce: 'CCE-35299-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    it { should have_property 'SMBServerNameHardeningLevel' }
    its('SMBServerNameHardeningLevel') { should cmp >= 1 }
  end
end

control '2.3.10.1_L1_Ensure_Network_access_Allow_anonymous_SIDName_translation_is_set_to_Disabled' do
  title "(L1) Ensure 'Network access: Allow anonymous SID/Name translation' is set to 'Disabled'"
  desc  "
    This policy setting determines whether an anonymous user can request security identifier (SID) attributes for another user, or use a SID to obtain its corresponding user name. Disable this policy setting to prevent unauthenticated users from obtaining user names that are associated with their respective SIDs.

    The recommended state for this setting is: Disabled.

    Rationale: If this policy setting is enabled, a user with local access could use the well-known Administrator's SID to learn the real name of the built-in Administrator account, even if it has been renamed. That person could then use the account name to initiate a password guessing attack.
  "
  impact 1.0
  tag cce: 'CCE-34914-2'
  describe wmi({ namespace: 'root\\rsop\\computer', query: "SELECT Setting FROM RSOP_SecuritySettingBoolean WHERE KeyName='LSAAnonymousNameLookup' AND Precedence=1" }) do
    its('Setting') { should cmp 'False' }
  end
end

control '2.3.10.2_L1_Ensure_Network_access_Do_not_allow_anonymous_enumeration_of_SAM_accounts_is_set_to_Enabled' do
  title "(L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts' is set to 'Enabled'"
  desc  "
    This policy setting controls the ability of anonymous users to enumerate the accounts in the Security Accounts Manager (SAM). If you enable this policy setting, users with anonymous connections cannot enumerate domain account user names on the workstations in your environment. This policy setting also allows additional restrictions on anonymous connections.

    The recommended state for this setting is: Enabled.

    Rationale: An unauthorized user could anonymously list account names and use the information to perform social engineering attacks or attempt to guess passwords. (Social engineering attacks try to deceive users in some way to obtain passwords or some form of security information.)
  "
  impact 1.0
  tag cce: 'CCE-34631-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'RestrictAnonymousSAM' }
    its('RestrictAnonymousSAM') { should cmp == 1 }
  end
end

control '2.3.10.3_L1_Ensure_Network_access_Do_not_allow_anonymous_enumeration_of_SAM_accounts_and_shares_is_set_to_Enabled' do
  title "(L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is set to 'Enabled'"
  desc  "
    This policy setting controls the ability of anonymous users to enumerate SAM accounts as well as shares. If you enable this policy setting, anonymous users will not be able to enumerate domain account user names and network share names on the workstations in your environment.

    The Network access: Do not allow anonymous enumeration of SAM accounts and shares setting is configured to Enabled for the two environments that are discussed in this guide.

    The recommended state for this setting is: Enabled.

    Rationale: An unauthorized user could anonymously list account names and shared resources and use the information to attempt to guess passwords or perform social engineering attacks.
  "
  impact 1.0
  tag cce: 'CCE-34723-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'RestrictAnonymous' }
    its('RestrictAnonymous') { should cmp == 1 }
  end
end

control '2.3.10.4_L1_Ensure_Network_access_Do_not_allow_storage_of_passwords_and_credentials_for_network_authentication_is_set_to_Enabled' do
  title "(L1) Ensure 'Network access: Do not allow storage of passwords and credentials for network authentication' is set to 'Enabled'"
  desc  "
    This policy setting determines whether the Stored User Names and Passwords feature may save passwords or credentials for later use when it gains domain authentication. If you enable this policy setting, the Stored User Names and Passwords feature of Windows does not store passwords and credentials.

    The recommended state for this setting is: Enabled.

    Rationale: Passwords that are cached can be accessed by the user when logged on to the computer. Although this information may sound obvious, a problem can arise if the user unknowingly executes hostile code that reads the passwords and forwards them to another, unauthorized user.
  "
  impact 1.0
  tag cce: 'CCE-33718-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'DisableDomainCreds' }
    its('DisableDomainCreds') { should cmp == 1 }
  end
end

control '2.3.10.5_L1_Ensure_Network_access_Let_Everyone_permissions_apply_to_anonymous_users_is_set_to_Disabled' do
  title "(L1) Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'"
  desc  "
    This policy setting determines what additional permissions are assigned for anonymous connections to the computer. If you enable this policy setting, anonymous Windows users are allowed to perform certain activities, such as enumerate the names of domain accounts and network shares. An unauthorized user could anonymously list account names and shared resources and use the information to guess passwords or perform social engineering attacks.

    The recommended state for this setting is: Disabled.

    Rationale: An unauthorized user could anonymously list account names and shared resources and use the information to attempt to guess passwords, perform social engineering attacks, or launch DoS attacks.
  "
  impact 1.0
  tag cce: 'CCE-35367-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'EveryoneIncludesAnonymous' }
    its('EveryoneIncludesAnonymous') { should cmp == 0 }
  end
end

control '2.3.10.6_L1_Ensure_Network_access_Named_Pipes_that_can_be_accessed_anonymously_is_set_to_None' do
  title "(L1) Ensure 'Network access: Named Pipes that can be accessed anonymously' is set to 'None'"
  desc  "
    This policy setting determines which communication sessions, or pipes, will have attributes and permissions that allow anonymous access.

    The recommended state for this setting is:
    <blank> (i.e. None).</blank>

    Rationale: Limiting named pipes that can be accessed anonymously will reduce the attack surface of the system.
  "
  impact 1.0
  tag cce: 'CCE-34965-4'
  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanManServer\\Parameters').NullSessionPipes&.reject { |value| value =~ /.+/ } || [] do
    it { should be_empty }
  end
end

control '2.3.10.7_L1_Ensure_Network_access_Remotely_accessible_registry_paths' do
  title "(L1) Ensure 'Network access: Remotely accessible registry paths'"
  desc  "
    This policy setting determines which registry paths will be accessible after referencing the WinReg key to determine access permissions to the paths.

    **Note:** This setting does not exist in Windows XP. There was a setting with that name in Windows XP, but it is called \"Network access: Remotely accessible registry paths and sub-paths\" in Windows Server 2003, Windows Vista, and Windows Server 2008.

    **Note:** When you configure this setting you specify a list of one or more objects. The delimiter used when entering the list is a line feed or carriage return, that is, type the first object on the list, press the Enter button, type the next object, press Enter again, etc. The setting value is stored as a comma-delimited list in group policy security templates. It is also rendered as a comma-delimited list in Group Policy Editor's display pane and the Resultant Set of Policy console. It is recorded in the registry as a line-feed delimited list in a REG_MULTI_SZ value.

    The recommended state for this setting is:

    System\\CurrentControlSet\\Control\\ProductOptions
    System\\CurrentControlSet\\Control\\Server Applications
    Software\\Microsoft\\Windows NT\\CurrentVersion

    Rationale: The registry is a database that contains computer configuration information, and much of the information is sensitive. An attacker could use this information to facilitate unauthorized activities. To reduce the risk of such an attack, suitable ACLs are assigned throughout the registry to help protect it from access by unauthorized users.
  "
  impact 1.0
  tag cce: 'CCE-33976-2'
  describe registry_key('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedExactPaths').Machine&.reject { |value| value =~ /^((System\\CurrentControlSet\\Control\\ProductOptions)|(System\\CurrentControlSet\\Control\\Server Applications)|(Software\\Microsoft\\Windows NT\\CurrentVersion))$/ } || [] do
    it { should be_empty }
  end
end

control '2.3.10.8_L1_Ensure_Network_access_Remotely_accessible_registry_paths_and_sub-paths' do
  title "(L1) Ensure 'Network access: Remotely accessible registry paths and sub-paths'"
  desc  "
    This policy setting determines which registry paths and sub-paths will be accessible when an application or process references the WinReg key to determine access permissions.

    **Note:** In Windows XP this setting is called \"Network access: Remotely accessible registry paths,\" the setting with that same name in Windows Vista, Windows Server 2008, and Windows Server 2003 does not exist in Windows XP.

    **Note #2:** When you configure this setting you specify a list of one or more objects. The delimiter used when entering the list is a line feed or carriage return, that is, type the first object on the list, press the Enter button, type the next object, press Enter again, etc. The setting value is stored as a comma-delimited list in group policy security templates. It is also rendered as a comma-delimited list in Group Policy Editor's display pane and the Resultant Set of Policy console. It is recorded in the registry as a line-feed delimited list in a REG_MULTI_SZ value.

    The recommended state for this setting is:

    System\\CurrentControlSet\\Control\\Print\\Printers
    System\\CurrentControlSet\\Services\\Eventlog
    Software\\Microsoft\\OLAP Server
    Software\\Microsoft\\Windows NT\\CurrentVersion\\Print
    Software\\Microsoft\\Windows NT\\CurrentVersion\\Windows
    System\\CurrentControlSet\\Control\\ContentIndex
    System\\CurrentControlSet\\Control\\Terminal Server
    System\\CurrentControlSet\\Control\\Terminal Server\\UserConfig
    System\\CurrentControlSet\\Control\\Terminal Server\\DefaultUserConfiguration
    Software\\Microsoft\\Windows NT\\CurrentVersion\\Perflib
    System\\CurrentControlSet\\Services\\SysmonLog

    Rationale: The registry contains sensitive computer configuration information that could be used by an attacker to facilitate unauthorized activities. The fact that the default ACLs assigned throughout the registry are fairly restrictive and help to protect the registry from access by unauthorized users reduces the risk of such an attack.
  "
  impact 1.0
  tag cce: 'CCE-35300-3'
  describe registry_key('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedPaths').Machine&.reject { |value| value =~ /^((System\\CurrentControlSet\\Control\\Print\\Printers)|(System\\CurrentControlSet\\Services\\Eventlog)|(Software\\Microsoft\\OLAP Server)|(Software\\Microsoft\\Windows NT\\CurrentVersion\\Print)|(Software\\Microsoft\\Windows NT\\CurrentVersion\\Windows)|(System\\CurrentControlSet\\Control\\ContentIndex)|(System\\CurrentControlSet\\Control\\Terminal Server)|(System\\CurrentControlSet\\Control\\Terminal Server\\UserConfig)|(System\\CurrentControlSet\\Control\\Terminal Server\\DefaultUserConfiguration)|(Software\\Microsoft\\Windows NT\\CurrentVersion\\Perflib)|(System\\CurrentControlSet\\Services\\SysmonLog))$/ } || [] do
    it { should be_empty }
  end
end

control '2.3.10.9_L1_Ensure_Network_access_Restrict_anonymous_access_to_Named_Pipes_and_Shares_is_set_to_Enabled' do
  title "(L1) Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'"
  desc  "
    When enabled, this policy setting restricts anonymous access to only those shares and pipes that are named in the Network access: Named pipes that can be accessed anonymously and Network access: Shares that can be accessed anonymously settings. This policy setting controls null session access to shares on your computers by adding RestrictNullSessAccess with the value 1 in the

    HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters

    registry key. This registry value toggles null session shares on or off to control whether the server service restricts unauthenticated clients' access to named resources.

    The recommended state for this setting is: Enabled.

    Rationale: Null sessions are a weakness that can be exploited through shares (including the default shares) on computers in your environment.
  "
  impact 1.0
  tag cce: 'CCE-33563-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    it { should have_property 'RestrictNullSessAccess' }
    its('RestrictNullSessAccess') { should cmp == 1 }
  end
end

control '2.3.10.10_L1_Ensure_Network_access_Restrict_clients_allowed_to_make_remote_calls_to_SAM_is_set_to_Administrators_Remote_Access_Allow_MS_only' do
  title "(L1) Ensure 'Network access: Restrict clients allowed to make remote calls to SAM' is set to 'Administrators: Remote Access: Allow' (MS only)"
  desc  "
    This policy setting allows you to restrict remote RPC connections to SAM.
    The recommended state for this setting is: Administrators: Remote Access: Allow.
    **Note:** A Windows 10 R1607, Server 2016 or newer OS is required to access and set this value in Group Policy.
    Rationale: To ensure that an unauthorized user cannot anonymously list local account names or groups and use the information to attempt to guess passwords or perform social engineering attacks. (Social engineering attacks try to deceive users in some way to obtain passwords or some form of security information.)
  "
  impact 1.0
  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'RestrictRemoteSAM' }
    its('RestrictRemoteSAM') { should eq 'O:BAG:BAD:(A;;RC;;;BA)' }
  end
end

control '2.3.10.11_L1_Ensure_Network_access_Shares_that_can_be_accessed_anonymously_is_set_to_None' do
  title "(L1) Ensure 'Network access: Shares that can be accessed anonymously' is set to 'None'"
  desc  "
    This policy setting determines which network shares can be accessed by anonymous users. The default configuration for this policy setting has little effect because all users have to be authenticated before they can access shared resources on the server.

    The recommended state for this setting is:
    <blank> (i.e. None).</blank>

    Rationale: It is very dangerous to enable this setting. Any shares that are listed can be accessed by any network user, which could lead to the exposure or corruption of sensitive data.
  "
  impact 1.0
  tag cce: 'CCE-34651-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters').NullSessionShares&.reject { |value| value =~ /^$/ } || [] do
    it { should be_empty }
  end
end

control '2.3.10.12_L1_Ensure_Network_access_Sharing_and_security_model_for_local_accounts_is_set_to_Classic_-_local_users_authenticate_as_themselves' do
  title "(L1) Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves'"
  desc  "
    This policy setting determines how network logons that use local accounts are authenticated. The Classic option allows precise control over access to resources, including the ability to assign different types of access to different users for the same resource. The Guest only option allows you to treat all users equally. In this context, all users authenticate as Guest only to receive the same access level to a given resource.

    The recommended state for this setting is: Classic - local users authenticate as themselves.

    Rationale: With the Guest only model, any user who can authenticate to your computer over the network does so with guest privileges, which probably means that they will not have write access to shared resources on that computer. Although this restriction does increase security, it makes it more difficult for authorized users to access shared resources on those computers because ACLs on those resources must include access control entries (ACEs) for the Guest account. With the Classic model, local accounts should be password protected. Otherwise, if Guest access is enabled, anyone can use those user accounts to access shared system resources.
  "
  impact 1.0
  tag cce: 'CCE-33719-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'ForceGuest' }
    its('ForceGuest') { should cmp == 0 }
  end
end

control '2.3.11.1_L1_Ensure_Network_security_Allow_Local_System_to_use_computer_identity_for_NTLM_is_set_to_Enabled' do
  title "(L1) Ensure 'Network security: Allow Local System to use computer identity for NTLM' is set to 'Enabled'"
  desc  "
    When enabled, this policy setting causes Local System services that use Negotiate to use the computer identity when NTLM authentication is selected by the negotiation. This policy is supported on at least Windows 7 or Windows Server 2008 R2.

    The recommended state for this setting is: Enabled.

    Rationale: When connecting to computers running versions of Windows earlier than Windows Vista or Windows Server 2008, services running as Local System and using SPNEGO (Negotiate) that revert to NTLM use the computer identity. In Windows 7, if you are connecting to a computer running Windows Server 2008 or Windows Vista, then a system service uses either the computer identity or a NULL session. When connecting with a NULL session, a system-generated session key is created, which provides no protection but allows applications to sign and encrypt data without errors. When connecting with the computer identity, both signing and encryption is supported in order to provide data protection.
  "
  impact 1.0
  tag cce: 'CCE-33141-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'UseMachineId' }
    its('UseMachineId') { should cmp == 1 }
  end
end

control '2.3.11.2_L1_Ensure_Network_security_Allow_LocalSystem_NULL_session_fallback_is_set_to_Disabled' do
  title "(L1) Ensure 'Network security: Allow LocalSystem NULL session fallback' is set to 'Disabled'"
  desc  "
    Allow NTLM to fall back to NULL session when used with LocalSystem. The default is TRUE up to Windows Vista / Server 2008 and FALSE from Windows 7 / Server 2008 R2 and beyond.

    The recommended state for this setting is: Disabled.

    Rationale: NULL sessions are less secure because by definition they are unauthenticated.
  "
  impact 1.0
  tag cce: 'CCE-35410-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa\\MSV1_0') do
    it { should have_property 'AllowNullSessionFallback' }
    its('AllowNullSessionFallback') { should cmp == 0 }
  end
end

control '2.3.11.3_L1_Ensure_Network_Security_Allow_PKU2U_authentication_requests_to_this_computer_to_use_online_identities_is_set_to_Disabled' do
  title "(L1) Ensure 'Network Security: Allow PKU2U authentication requests to this computer to use online identities' is set to 'Disabled'"
  desc  "
    This setting determines if online identities are able to authenticate to this computer.

    Windows 7 and Windows Server 2008 R2 introduced an extension to the Negotiate authentication package, Spnego.dll. In previous versions of Windows, Negotiate decides whether to use Kerberos or NTLM for authentication. The extension SSP for Negotiate, Negoexts, which is treated as an authentication protocol by Windows, supports Microsoft SSPs including PKU2U.

    When computers are configured to accept authentication requests by using online IDs, Negoexts.dll calls the PKU2U SSP on the computer that is used to log on. The PKU2U SSP obtains a local certificate and exchanges the policy between the peer computers. When validated on the peer computer, the certificate within the metadata is sent to the logon peer for validation and associates the user's certificate to a security token and the logon process completes.

    The recommended state for this setting is: Disabled.

    Rationale: The PKU2U protocol is a peer-to-peer authentication protocol, in most managed networks authentication should be managed centrally.
  "
  impact 1.0
  tag cce: 'CCE-35411-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa\\pku2u') do
    it { should have_property 'AllowOnlineID' }
    its('AllowOnlineID') { should cmp == 0 }
  end
end

control '2.3.11.4_L1_Ensure_Network_Security_Configure_encryption_types_allowed_for_Kerberos_is_set_to_RC4_HMAC_MD5_AES128_HMAC_SHA1_AES256_HMAC_SHA1_Future_encryption_types' do
  title "(L1) Ensure 'Network Security: Configure encryption types allowed for Kerberos' is set to 'RC4_HMAC_MD5, AES128_HMAC_SHA1, AES256_HMAC_SHA1, Future encryption types'"
  desc  "
    This policy setting allows you to set the encryption types that Kerberos is allowed to use. This policy is supported on at least Windows 7 or Windows Server 2008 R2.

    The recommended state for this setting is: RC4_HMAC_MD5, AES128_HMAC_SHA1, AES256_HMAC_SHA1, Future encryption types.

    Rationale: The strength of each encryption algorithm varies from one to the next, choosing stronger algorithms will reduce the risk of compromise however doing so may cause issues when the computer attempts to authenticate with systems that do not support them.
  "
  impact 1.0
  tag cce: 'CCE-35786-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System\\Kerberos\\Parameters') do
    it { should have_property 'SupportedEncryptionTypes' }
    its('SupportedEncryptionTypes') { should cmp == 2147483640 }
  end
end

control '2.3.11.5_L1_Ensure_Network_security_Do_not_store_LAN_Manager_hash_value_on_next_password_change_is_set_to_Enabled' do
  title "(L1) Ensure 'Network security: Do not store LAN Manager hash value on next password change' is set to 'Enabled'"
  desc  "
    This policy setting determines whether the LAN Manager (LM) hash value for the new password is stored when the password is changed. The LM hash is relatively weak and prone to attack compared to the cryptographically stronger Microsoft Windows NT hash.

    **Note:** Older operating systems and some third-party applications may fail when this policy setting is enabled. Also, note that the password will need to be changed on all accounts after you enable this setting to gain the proper benefit.

    The recommended state for this setting is: Enabled.

    Rationale: The SAM file can be targeted by attackers who seek access to username and password hashes. Such attacks use special tools to crack passwords, which can then be used to impersonate users and gain access to resources on your network. These types of attacks will not be prevented if you enable this policy setting, but it will be much more difficult for these types of attacks to succeed.
  "
  impact 1.0
  tag cce: 'CCE-35225-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'NoLMHash' }
    its('NoLMHash') { should cmp == 1 }
  end
end

control '2.3.11.6_L1_Ensure_Network_security_Force_logoff_when_logon_hours_expire_is_set_to_Enabled' do
  title "(L1) Ensure 'Network security: Force logoff when logon hours expire' is set to 'Enabled'"
  desc  "
    This policy setting, which determines whether to disconnect users who are connected to the local computer outside their user account's valid logon hours, affects the SMB component. If you enable this policy setting, client sessions with the SMB server will be disconnected when the client's logon hours expire. If you disable this policy setting, established client sessions will be maintained after the client's logon hours expire.

    The recommended state for this setting is: Enabled.

    Rationale: If this setting is disabled, a user could remain connected to the computer outside of their allotted logon hours.
  "
  impact 1.0
  tag cce: 'CCE-34993-6'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters') do
    it { should have_property 'EnableForcedLogOff' }
    its('EnableForcedLogOff') { should cmp == 1 }
  end
end

control '2.3.11.7_L1_Ensure_Network_security_LAN_Manager_authentication_level_is_set_to_Send_NTLMv2_response_only._Refuse_LM__NTLM' do
  title "(L1) Ensure 'Network security: LAN Manager authentication level' is set to 'Send NTLMv2 response only. Refuse LM  NTLM'"
  desc  "
    LAN Manager (LM) is a family of early Microsoft client/server software that allows users to link personal computers together on a single network. Network capabilities include transparent file and print sharing, user security features, and network administration tools. In Active Directory domains, the Kerberos protocol is the default authentication protocol. However, if the Kerberos protocol is not negotiated for some reason, Active Directory will use LM, NTLM, or NTLMv2. LAN Manager authentication includes the LM, NTLM, and NTLM version 2 (NTLMv2) variants, and is the protocol that is used to authenticate all Windows clients when they perform the following operations:

    * Join a domain
    * Authenticate between Active Directory forests
    * Authenticate to down-level domains
    * Authenticate to computers that do not run Windows 2000, Windows Server 2003, or Windows XP)
    * Authenticate to computers that are not in the domain
    The possible values for the Network security: LAN Manager authentication level setting are:

    * Send LM  NTLM responses
    * Send LM  NTLM #x2014; use NTLMv2 session security if negotiated
    * Send NTLM responses only
    * Send NTLMv2 responses only
    * Send NTLMv2 responses only\\refuse LM
    * Send NTLMv2 responses only\\refuse LM  NTLM
    * Not Defined
    The Network security: LAN Manager authentication level setting determines which challenge/response authentication protocol is used for network logons. This choice affects the authentication protocol level that clients use, the session security level that the computers negotiate, and the authentication level that servers accept as follows:

    * Send LM  NTLM responses. Clients use LM and NTLM authentication and never use NTLMv2 session security. Domain controllers accept LM, NTLM, and NTLMv2 authentication.
    * Send LM  NTLM - use NTLMv2 session security if negotiated. Clients use LM and NTLM authentication and use NTLMv2 session security if the server supports it. Domain controllers accept LM, NTLM, and NTLMv2 authentication.
    * Send NTLM response only. Clients use NTLM authentication only and use NTLMv2 session security if the server supports it. Domain controllers accept LM, NTLM, and NTLMv2 authentication.
    * Send NTLMv2 response only. Clients use NTLMv2 authentication only and use NTLMv2 session security if the server supports it. Domain controllers accept LM, NTLM, and NTLMv2 authentication.
    * Send NTLMv2 response only\\refuse LM. Clients use NTLMv2 authentication only and use NTLMv2 session security if the server supports it. Domain controllers refuse LM (accept only NTLM and NTLMv2 authentication).
    * Send NTLMv2 response only\\refuse LM  NTLM. Clients use NTLMv2 authentication only and use NTLMv2 session security if the server supports it. Domain controllers refuse LM and NTLM (accept only NTLMv2 authentication).
    * These settings correspond to the levels discussed in other Microsoft documents as follows:
    * Level 0 - Send LM and NTLM response; never use NTLMv2 session security. Clients use LM and NTLM authentication, and never use NTLMv2 session security. Domain controllers accept LM, NTLM, and NTLMv2 authentication.
    * Level 1 - Use NTLMv2 session security if negotiated. Clients use LM and NTLM authentication, and use NTLMv2 session security if the server supports it. Domain controllers accept LM, NTLM, and NTLMv2 authentication.
    * Level 2 - Send NTLM response only. Clients use only NTLM authentication, and use NTLMv2 session security if the server supports it. Domain controllers accept LM, NTLM, and NTLMv2 authentication.
    * Level 3 - Send NTLMv2 response only. Clients use NTLMv2 authentication, and use NTLMv2 session security if the server supports it. Domain controllers accept LM, NTLM, and NTLMv2 authentication.
    * Level 4 - Domain controllers refuse LM responses. Clients use NTLM authentication, and use NTLMv2 session security if the server supports it. Domain controllers refuse LM authentication, that is, they accept NTLM and NTLMv2.
    * Level 5 - Domain controllers refuse LM and NTLM responses (accept only NTLMv2). Clients use NTLMv2 authentication, use and NTLMv2 session security if the server supports it. Domain controllers refuse NTLM and LM authentication (they accept only NTLMv2).
    The recommended state for this setting is: Send NTLMv2 response only. Refuse LM  NTLM.

    Rationale: In Windows Vista, this setting is undefined. However, in Windows 2000, Windows Server 2003, and Windows XP clients are configured by default to send LM and NTLM authentication responses (Windows 95-based and Windows 98-based clients only send LM). The default setting on servers allows all clients to authenticate with servers and use their resources. However, this means that LM responses#x2014;the weakest form of authentication response#x2014;are sent over the network, and it is potentially possible for attackers to sniff that traffic to more easily reproduce the user's password.

    The Windows 95, Windows 98, and Windows NT operating systems cannot use the Kerberos version 5 protocol for authentication. For this reason, in a Windows Server 2003 domain, these computers authenticate by default with both the LM and NTLM protocols for network authentication. You can enforce a more secure authentication protocol for Windows 95, Windows 98, and Windows NT by using NTLMv2. For the logon process, NTLMv2 uses a secure channel to protect the authentication process. Even if you use NTLMv2 for earlier clients and servers, Windows-based clients and servers that are members of the domain will use the Kerberos authentication protocol to authenticate with Windows Server 2003 domain controllers.
  "
  impact 1.0
  tag cce: 'CCE-35302-9'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa') do
    it { should have_property 'LmCompatibilityLevel' }
    its('LmCompatibilityLevel') { should cmp == 5 }
  end
end

control '2.3.11.8_L1_Ensure_Network_security_LDAP_client_signing_requirements_is_set_to_Negotiate_signing_or_higher' do
  title "(L1) Ensure 'Network security: LDAP client signing requirements' is set to 'Negotiate signing' or higher"
  desc  "
    This policy setting determines the level of data signing that is requested on behalf of clients that issue LDAP BIND requests, as follows:
    - None. The LDAP BIND request is issued with the caller-specified options.
    - Negotiate signing. If Transport Layer Security/Secure Sockets Layer (TLS/SSL) has not been started, the LDAP BIND request is initiated with the LDAP data signing option set in addition to the caller-specified options. If TLS/SSL has been started, the LDAP BIND request is initiated with the caller-specified options.
    - Require signature. This level is the same as Negotiate signing. However, if the LDAP server's intermediate saslBindInProgress response does not indicate that LDAP traffic signing is required, the caller is told that the LDAP BIND command request failed.

    **Note:** This policy setting does not have any impact on ldap_simple_bind or ldap_simple_bind_s. No Microsoft LDAP clients that are included with Windows XP Professional use ldap_simple_bind or ldap_simple_bind_s to communicate with a domain controller.

    The possible values for the Network security: LDAP client signing requirements setting are:
    - None
    - Negotiate signing
    - Require signature
    - Not Defined

    The recommended state for this setting is: Negotiate signing. Configuring this setting to Require signing also conforms with the benchmark.

    Rationale: Unsigned network traffic is susceptible to man-in-the-middle attacks in which an intruder captures the packets between the client and server, modifies them, and then forwards them to the server. For an LDAP server, this susceptibility means that an attacker could cause a server to make decisions that are based on false or altered data from the LDAP queries. To lower this risk in your network, you can implement strong physical security measures to protect the network infrastructure. Also, you can make all types of man-in-the-middle attacks extremely difficult if you require digital signatures on all network packets by means of IPsec authentication headers.
  "
  impact 1.0
  tag cce: 'CCE-33802-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LDAP') do
    it { should have_property 'LDAPClientIntegrity' }
    its('LDAPClientIntegrity') { should cmp >= 1 }
  end
end

control '2.3.11.9_L1_Ensure_Network_security_Minimum_session_security_for_NTLM_SSP_based_including_secure_RPC_clients_is_set_to_Require_NTLMv2_session_security_Require_128-bit_encryption' do
  title "(L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) clients' is set to 'Require NTLMv2 session security, Require 128-bit encryption'"
  desc  "
    This policy setting determines which behaviors are allowed for applications using the NTLM Security Support Provider (SSP). The SSP Interface (SSPI) is used by applications that need authentication services. The setting does not modify how the authentication sequence works but instead require certain behaviors in applications that use the SSPI.

    The possible values for the Network security: Minimum session security for NTLM SSP based (including secure RPC) clients setting are:
    - Require message confidentiality. This option is only available in Windows XP and Windows Server 2003, the connection will fail if encryption is not negotiated. Encryption converts data into a form that is not readable until decrypted.
    - Require message integrity. This option is only available in Windows XP and Windows Server 2003, the connection will fail if message integrity is not negotiated. The integrity of a message can be assessed through message signing. Message signing proves that the message has not been tampered with; it attaches a cryptographic signature that identifies the sender and is a numeric representation of the contents of the message.
    - Require 128-bit encryption. The connection will fail if strong encryption (128-bit) is not negotiated.
    - Require NTLMv2
     session security. The connection will fail if the NTLMv2 protocol is not negotiated.
    - Not Defined.

    The recommended state for this setting is: Require NTLMv2 session security, Require 128-bit encryption.

    Rationale: You can enable all of the options for this policy setting to help protect network traffic that uses the NTLM Security Support Provider (NTLM SSP) from being exposed or tampered with by an attacker who has gained access to the same network. In other words, these options help protect against man-in-the-middle attacks.
  "
  impact 1.0
  tag cce: 'CCE-35447-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa\\MSV1_0') do
    it { should have_property 'NTLMMinClientSec' }
    its('NTLMMinClientSec') { should cmp == 537395200 }
  end
end

control '2.3.11.10_L1_Ensure_Network_security_Minimum_session_security_for_NTLM_SSP_based_including_secure_RPC_servers_is_set_to_Require_NTLMv2_session_security_Require_128-bit_encryption' do
  title "(L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) servers' is set to 'Require NTLMv2 session security, Require 128-bit encryption'"
  desc  "
    This policy setting determines which behaviors are allowed for applications using the NTLM Security Support Provider (SSP). The SSP Interface (SSPI) is used by applications that need authentication services. The setting does not modify how the authentication sequence works but instead require certain behaviors in applications that use the SSPI.

    The possible values for the Network security: Minimum session security for NTLM SSP based (including secure RPC) servers setting are:
    - Require message confidentiality. This option is only available in Windows XP and Windows Server 2003, the connection will fail if encryption is not negotiated. Encryption converts data into a form that is not readable until decrypted.
    - Require message integrity. This option is only available in Windows XP and Windows Server 2003, the connection will fail if message integrity is not negotiated. The integrity of a message can be assessed through message signing. Message signing proves that the message has not been tampered with; it attaches a cryptographic signature that identifies the sender and is a numeric representation of the contents of the message.
    - Require 128-bit encryption. The connection will fail if strong encryption (128-bit) is not negotiated.
    - Require NTLMv2
     session security. The connection will fail if the NTLMv2 protocol is not negotiated.
    - Not Defined.

    The recommended state for this setting is: Require NTLMv2 session security, Require 128-bit encryption.

    Rationale: You can enable all of the options for this policy setting to help protect network traffic that uses the NTLM Security Support Provider (NTLM SSP) from being exposed or tampered with by an attacker who has gained access to the same network. That is, these options help protect against man-in-the-middle attacks.
  "
  impact 1.0
  tag cce: 'CCE-35108-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Lsa\\MSV1_0') do
    it { should have_property 'NTLMMinServerSec' }
    its('NTLMMinServerSec') { should cmp == 537395200 }
  end
end

control '2.3.14.1_L1_Ensure_System_cryptography_Force_strong_key_protection_for_user_keys_stored_on_the_computer_is_set_to_User_is_prompted_when_the_key_is_first_used_or_higher' do
  title "(L1) Ensure 'System cryptography: Force strong key protection for user keys stored on the computer' is set to 'User is prompted when the key is first used' or higher"
  desc  "
    This policy setting determines whether users' private keys (such as their S-MIME keys) require a password to be used.

    The recommended state for this setting is: User is prompted when the key is first used. Configuring this setting to User must enter a password each time they use a key also conforms to the benchmark.

    Rationale: If a user's account is compromised or their computer is inadvertently left unsecured the malicious user can use the keys stored for the user to access protected resources. You can configure this policy setting so that users must provide a password that is distinct from their domain password every time they use a key. This configuration makes it more difficult for an attacker to access locally stored user keys, even if the attacker takes control of the user's computer and determines their logon password.
  "
  impact 1.0
  tag cce: 'CCE-35008-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Cryptography') do
    it { should have_property 'ForceKeyProtection' }
    its('ForceKeyProtection') { should cmp >= 1 }
  end
end

control '2.3.15.1_L1_Ensure_System_objects_Require_case_insensitivity_for_non-Windows_subsystems_is_set_to_Enabled' do
  title "(L1) Ensure 'System objects: Require case insensitivity for non-Windows subsystems' is set to 'Enabled'"
  desc  "
    This policy setting determines whether case insensitivity is enforced for all subsystems. The Microsoft Win32' subsystem is case insensitive. However, the kernel supports case sensitivity for other subsystems, such as the Portable Operating System Interface for UNIX (POSIX). Because Windows is case insensitive (but the POSIX subsystem will support case sensitivity), failure to enforce this policy setting makes it possible for a user of the POSIX subsystem to create a file with the same name as another file by using mixed case to label it. Such a situation can block access to these files by another user who uses typical Win32 tools, because only one of the files will be available.

    The recommended state for this setting is: Enabled.

    Rationale: Because Windows is case-insensitive but the POSIX subsystem will support case sensitivity, failure to enable this policy setting would make it possible for a user of that subsystem to create a file with the same name as another file but with a different mix of upper and lower case letters. Such a situation could potentially confuse users when they try to access such files from normal Win32 tools because only one of the files will be available.
  "
  impact 1.0
  tag cce: 'CCE-35008-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Session Manager\\Kernel') do
    it { should have_property 'ObCaseInsensitive' }
    its('ObCaseInsensitive') { should cmp == 1 }
  end
end

control '2.3.15.2_L1_Ensure_System_objects_Strengthen_default_permissions_of_internal_system_objects_e.g._Symbolic_Links_is_set_to_Enabled' do
  title "(L1) Ensure 'System objects: Strengthen default permissions of internal system objects (e.g. Symbolic Links)' is set to 'Enabled'"
  desc  "
    This policy setting determines the strength of the default discretionary access control list (DACL) for objects. The setting helps secure objects that can be located and shared among processes and its default configuration strengthens the DACL, because it allows users who are not administrators to read shared objects but does not allow them to modify any that they did not create.

    The recommended state for this setting is: Enabled.

    Rationale: This setting determines the strength of the default DACL for objects. Windows Server 2003 maintains a global list of shared computer resources so that objects can be located and shared among processes. Each type of object is created with a default DACL that specifies who can access the objects and with what permissions. If you enable this setting, the default DACL is strengthened because non-administrator users are allowed to read shared objects but not modify shared objects that they did not create.
  "
  impact 1.0
  tag cce: 'CCE-35232-8'
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Session Manager') do
    it { should have_property 'ProtectionMode' }
    its('ProtectionMode') { should cmp == 1 }
  end
end

control '2.3.17.1_L1_Ensure_User_Account_Control_Admin_Approval_Mode_for_the_Built-in_Administrator_account_is_set_to_Enabled' do
  title "(L1) Ensure 'User Account Control: Admin Approval Mode for the Built-in Administrator account' is set to 'Enabled'"
  desc  "
    This policy setting controls the behavior of Admin Approval Mode for the built-in Administrator account.

    The options are:
    - Enabled: The built-in Administrator account uses Admin Approval Mode. By default, any operation that requires elevation of privilege will prompt the user to approve the operation.
    - Disabled: (Default) The built-in Administrator account runs all applications with full administrative privilege.

    The recommended state for this setting is: Enabled.

    Rationale: One of the risks that the User Account Control feature introduced with Windows Vista is trying to mitigate is that of malicious software running under elevated credentials without the user or administrator being aware of its activity. An attack vector for these programs was to discover the password of the account named \"Administrator\" because that user account was created for all installations of Windows. To address this risk, in Windows Vista the built-in Administrator account is disabled. In a default installation of a new computer, accounts with administrative control over the computer are initially set up in one of two ways:
    - If the computer is not joined to a domain, the first user account you create has the equivalent permissions as a local administrator.
    - If the computer is joined to a domain, no local administrator accounts are created. The Enterprise or Domain Administrator must log on to the computer and
     create one if a local administrator account is warranted.

    Once Windows Vista is installed, the built-in Administrator account may be enabled, but we strongly recommend that this account remain disabled.
  "
  impact 1.0
  tag cce: 'CCE-35338-3'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'FilterAdministratorToken' }
    its('FilterAdministratorToken') { should cmp == 1 }
  end
end

control '2.3.17.2_L1_Ensure_User_Account_Control_Behavior_of_the_elevation_prompt_for_administrators_in_Admin_Approval_Mode_is_set_to_Prompt_for_consent_on_the_secure_desktop' do
  title "(L1) Ensure 'User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode' is set to 'Prompt for consent on the secure desktop'"
  desc  "
    This policy setting controls the behavior of the elevation prompt for administrators.

    The options are:
    - Elevate without prompting: Allows privileged accounts to perform an operation that requires elevation without requiring consent or credentials. **Note:** Use this option only in the most constrained environments.
    - Prompt for credentials on the secure desktop: When an operation requires elevation of privilege, the user is prompted on the secure desktop to enter a privileged user name and password. If the user enters valid credentials, the operation continues with the user's highest available privilege.
    - Prompt for consent on the secure desktop: When an operation requires elevation of privilege, the user is prompted on the secure desktop to select either Permit or Deny. If the user selects Permit, the operation continues with the user's highest available privilege.
    - Prompt for credentials: When an operation requires elevation of privilege, the user is prompted to enter an
     administrative user name and password. If the user enters valid credentials, the operation continues with the applicable privilege.
    - Prompt for consent: When an operation requires elevation of privilege, the user is prompted to select either Permit or Deny. If the user selects Permit, the operation continues with the user's highest available privilege.
    - Prompt for consent for non-Windows binaries: (Default) When an operation for a non-Microsoft application requires elevation of privilege, the user is prompted on the secure desktop to select either Permit or Deny. If the user selects Permit, the operation continues with the user's highest available privilege.

    The recommended state for this setting is: Prompt for consent on the secure desktop.

    Rationale: One of the risks that the UAC feature introduced with Windows Vista is trying to mitigate is that of malicious software running under elevated credentials without the user or administrator being aware of its activity. This setting raises awareness to the administrator of elevated privilege operations and permits the administrator to prevent a malicious program from elevating its privilege when the program attempts to do so.
  "
  impact 1.0
  tag cce: 'CCE-33784-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'ConsentPromptBehaviorAdmin' }
    its('ConsentPromptBehaviorAdmin') { should cmp == 2 }
  end
end

control '2.3.17.3_L1_Ensure_User_Account_Control_Behavior_of_the_elevation_prompt_for_standard_users_is_set_to_Automatically_deny_elevation_requests' do
  title "(L1) Ensure 'User Account Control: Behavior of the elevation prompt for standard users' is set to 'Automatically deny elevation requests'"
  desc  "
    This policy setting controls the behavior of the elevation prompt for standard users. The options are:

    * Prompt for credentials: When an operation requires elevation of privilege, the user is prompted to enter an administrative user name and password. If the user enters valid credentials, the operation continues with the applicable privilege.
    * Automatically deny elevation requests: When an operation requires elevation of privilege, a configurable access denied error message is displayed. An enterprise that is running desktops as standard user may choose this setting to reduce help desk calls.
    * Prompt for credentials on the secure desktop: (Default) When an operation requires elevation of privilege, the user is prompted on the secure desktop to enter a different user name and password. If the user enters valid credentials, the operation continues with the applicable privilege. Note that this option was introduced in Windows 7 and it is not applicable to computers running Windows Vista or Windows Server 2008.
    The recommended state for this setting is: Automatically deny elevation requests.

    Rationale: One of the risks that the User Account Control feature introduced with Windows Vista is trying to mitigate is that of malicious programs running under elevated credentials without the user or administrator being aware of their activity. This setting raises awareness to the user that a program requires the use of elevated privilege operations and requires that the user be able to supply administrative credentials in order for the program to run.
  "
  impact 1.0
  tag cce: 'CCE-33785-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'ConsentPromptBehaviorUser' }
    its('ConsentPromptBehaviorUser') { should cmp == 0 }
  end
end

control '2.3.17.4_L1_Ensure_User_Account_Control_Detect_application_installations_and_prompt_for_elevation_is_set_to_Enabled' do
  title "(L1) Ensure 'User Account Control: Detect application installations and prompt for elevation' is set to 'Enabled'"
  desc  "
    This policy setting controls the behavior of application installation detection for the computer.

    The options are:
    - Enabled: (Default for home) When an application installation package is detected that requires elevation of privilege, the user is prompted to enter an administrative user name and password. If the user enters valid credentials, the operation continues with the applicable privilege.
    - Disabled: (Default for enterprise) Application installation packages are not detected and prompted for elevation. Enterprises that are running standard user desktops and use delegated installation technologies such as Group Policy Software Installation or Systems Management Server (SMS) should disable this policy setting. In this case, installer detection is unnecessary.

    The recommended state for this setting is: Enabled.

    Rationale: Some malicious software will attempt to install itself after being given permission to run. For example, malicious software with a trusted application shell. The user may have given permission for the program to run because the program is trusted, but if they are then prompted for installation of an unknown component this provides another way of trapping the software before it can do damage
  "
  impact 1.0
  tag cce: 'CCE-35429-0'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'EnableInstallerDetection' }
    its('EnableInstallerDetection') { should cmp == 1 }
  end
end

control '2.3.17.5_L1_Ensure_User_Account_Control_Only_elevate_UIAccess_applications_that_are_installed_in_secure_locations_is_set_to_Enabled' do
  title "(L1) Ensure 'User Account Control: Only elevate UIAccess applications that are installed in secure locations' is set to 'Enabled'"
  desc  "
    This policy setting controls whether applications that request to run with a User Interface Accessibility (UIAccess) integrity level must reside in a secure location in the file system. Secure locations are limited to the following:
    - #x2026;\\Program Files\\, including subfolders
    - #x2026;\\Windows\\system32\\
    - #x2026;\\Program Files (x86)\\, including subfolders for 64-bit versions of Windows

    **Note:** Windows enforces a public key infrastructure (PKI) signature check on any interactive application that requests to run with a UIAccess integrity level regardless of the state of this security setting.

    The options are:
    - Enabled: (Default) If an application resides in a secure location in the file system, it runs only with UIAccess integrity.
    - Disabled: An application runs with UIAccess integrity even if it does not reside in a secure location in the file system.

    The recommended state for this setting is: Enabled.

    Rationale: UIAccess Integrity allows an application to bypass User Interface Privilege Isolation (UIPI) restrictions when an application is elevated in privilege from a standard user to an administrator. This is required to support accessibility features such as screen readers that are transmitting user interfaces to alternative forms. A process that is started with UIAccess rights has the following abilities:
    - To set the foreground window.
    - To drive any application window using SendInput function.
    - To use read input for all integrity levels using low-level hooks, raw input, GetKeyState, GetAsyncKeyState, and GetKeyboardInput.
    - To set journal hooks.
    - To uses AttachThreadInput to attach a thread to a higher integrity input queue.
  "
  impact 1.0
  tag cce: 'CCE-35401-9'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'EnableSecureUIAPaths' }
    its('EnableSecureUIAPaths') { should cmp == 1 }
  end
end

control '2.3.17.6_L1_Ensure_User_Account_Control_Run_all_administrators_in_Admin_Approval_Mode_is_set_to_Enabled' do
  title "(L1) Ensure 'User Account Control: Run all administrators in Admin Approval Mode' is set to 'Enabled'"
  desc  "
    This policy setting controls the behavior of all User Account Control (UAC) policy settings for the computer. If you change this policy setting, you must restart your computer.

    The options are:
    - Enabled: (Default) Admin Approval Mode is enabled. This policy must be enabled and related UAC policy settings must also be set appropriately to allow the built-in Administrator account and all other users who are members of the Administrators group to run in Admin Approval Mode.
    - Disabled: Admin Approval Mode and all related UAC policy settings are disabled. **Note:** If this policy setting is disabled, the Security Center notifies you that the overall security of the operating system has been reduced.

    The recommended state for this setting is: Enabled.

    Rationale: This is the setting that turns on or off UAC. If this setting is disabled, UAC will not be used and any security benefits and risk mitigations that are dependent on UAC will not be present on the system.
  "
  impact 1.0
  tag cce: 'CCE-33788-1'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'EnableLUA' }
    its('EnableLUA') { should cmp == 1 }
  end
end

control '2.3.17.7_L1_Ensure_User_Account_Control_Switch_to_the_secure_desktop_when_prompting_for_elevation_is_set_to_Enabled' do
  title "(L1) Ensure 'User Account Control: Switch to the secure desktop when prompting for elevation' is set to 'Enabled'"
  desc  "
    This policy setting controls whether the elevation request prompt is displayed on the interactive user's desktop or the secure desktop.

    The options are:
    - Enabled: (Default) All elevation requests go to the secure desktop regardless of prompt behavior policy settings for administrators and standard users.
    - Disabled: All elevation requests go to the interactive user's desktop. Prompt behavior policy settings for administrators and standard users are used.

    The recommended state for this setting is: Enabled.

    Rationale: Elevation prompt dialog boxes can be spoofed, causing users to disclose their passwords to malicious software.
  "
  impact 1.0
  tag cce: 'CCE-33815-2'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'PromptOnSecureDesktop' }
    its('PromptOnSecureDesktop') { should cmp == 1 }
  end
end

control '2.3.17.8_L1_Ensure_User_Account_Control_Virtualize_file_and_registry_write_failures_to_per-user_locations_is_set_to_Enabled' do
  title "(L1) Ensure 'User Account Control: Virtualize file and registry write failures to per-user locations' is set to 'Enabled'"
  desc  "
    This policy setting controls whether application write failures are redirected to defined registry and file system locations. This policy setting mitigates applications that run as administrator and write run-time application data to %ProgramFiles%, %Windir%, %Windir%\\system32, or HKEY_LOCAL_MACHINE\\Software.

    The options are:
    - Enabled: (Default) Application write failures are redirected at run time to defined user locations for both the file system and registry.
    - Disabled: Applications that write data to protected locations fail.

    The recommended state for this setting is: Enabled.

    Rationale: This setting reduces vulnerabilities by ensuring that legacy applications only write data to permitted locations.
  "
  impact 1.0
  tag cce: 'CCE-35459-7'
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
    it { should have_property 'EnableVirtualization' }
    its('EnableVirtualization') { should cmp == 1 }
  end
end
