#
# Profile:: inspec_os_win10_21h1_cis
# Control:: section_17
#
# Copyright:: 2021, The Authors, All Rights Reserved.

control '17.1.1_L1_Ensure_Audit_Credential_Validation_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit Credential Validation' is set to 'Success and Failure'"
  desc  "
    This subcategory reports the results of validation tests on credentials submitted for a user account logon request. These events occur on the computer that is authoritative for the credentials. For domain accounts, the domain controller is authoritative, whereas for local accounts, the local computer is authoritative. In domain environments, most of the Account Logon events occur in the Security log of the domain controllers that are authoritative for the domain accounts. However, these events can occur on other computers in the organization when local accounts are used to log on. Events for this subcategory include:

    * 4774: An account was mapped for logon.
    * 4775: An account could not be mapped for logon.
    * 4776: The domain controller attempted to validate the credentials for an account.
    * 4777: The domain controller failed to validate the credentials for an account.
    The recommended state for this setting is: Success and Failure.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35494-4'
  describe audit_policy do
    its('Credential Validation') { should eq 'Success and Failure' }
  end
end

control '17.2.1_L1_Ensure_Audit_Application_Group_Management_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit Application Group Management' is set to 'Success and Failure'"
  desc  "
    This policy setting allows you to audit events generated by changes to application groups such as the following:

    * Application group is created, changed, or deleted.
    * Member is added or removed from an application group.
    Application groups are utilized by Windows Authorization Manager, which is a flexible framework created by Microsoft for integrating role-based access control (RBAC) into applications. More information on Windows Authorization Manager is available at [MSDN - Windows Authorization Manager](https://msdn.microsoft.com/en-us/library/bb897401.aspx).

    The recommended state for this setting is: Success and Failure.

    Rationale: Auditing events in this category may be useful when investigating an incident.
  "
  impact 1.0
  tag cce: 'CCE-32932-6'
  describe audit_policy do
    its('Application Group Management') { should eq 'Success and Failure' }
  end
end

control '17.2.2_L1_Ensure_Audit_Security_Group_Management_is_set_to_include Success' do
  title "(L1) Ensure 'Audit Security Group Management' is set to include 'Success'"
  desc  "
    This subcategory reports each event of security group management, such as when a security group is created, changed, or deleted or when a member is added to or removed from a security group. If you enable this Audit policy setting, administrators can track events to detect malicious, accidental, and authorized creation of security group accounts. Events for this subcategory include:

    * 4727: A security-enabled global group was created.
    * 4728: A member was added to a security-enabled global group.
    * 4729: A member was removed from a security-enabled global group.
    * 4730: A security-enabled global group was deleted.
    * 4731: A security-enabled local group was created.
    * 4732: A member was added to a security-enabled local group.
    * 4733: A member was removed from a security-enabled local group.
    * 4734: A security-enabled local group was deleted.
    * 4735: A security-enabled local group was changed.
    * 4737: A security-enabled global group was changed.
    * 4754: A security-enabled universal group was created.
    * 4755: A security-enabled universal group was changed.
    * 4756: A member was added to a security-enabled universal group.
    * 4757: A member was removed from a security-enabled universal group.
    * 4758: A security-enabled universal group was deleted.
    * 4764: A group's type was changed.
    The recommended state for this setting is to include: Success.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35498-5'
  describe audit_policy do
    its('Security Group Management') { should match /Success/ }
  end
end

control '17.2.3_L1_Ensure_Audit_User_Account_Management_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit User Account Management' is set to 'Success and Failure'"
  desc  "
    This subcategory reports each event of user account management, such as when a user account is created, changed, or deleted; a user account is renamed, disabled, or enabled; or a password is set or changed. If you enable this Audit policy setting, administrators can track events to detect malicious, accidental, and authorized creation of user accounts. Events for this subcategory include:

    * 4720: A user account was created.
    * 4722: A user account was enabled.
    * 4723: An attempt was made to change an account's password.
    * 4724: An attempt was made to reset an account's password.
    * 4725: A user account was disabled.
    * 4726: A user account was deleted.
    * 4738: A user account was changed.
    * 4740: A user account was locked out.
    * 4765: SID History was added to an account.
    * 4766: An attempt to add SID History to an account failed.
    * 4767: A user account was unlocked.
    * 4780: The ACL was set on accounts which are members of administrators groups.
    * 4781: The name of an account was changed:
    * 4794: An attempt was made to set the Directory Services Restore Mode.
    * 5376: Credential Manager credentials were backed up.
    * 5377: Credential Manager credentials were restored from a backup.
    The recommended state for this setting is: Success and Failure.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35499-3'
  describe audit_policy do
    its('User Account Management') { should eq 'Success and Failure' }
  end
end

control '17.3.1_L1_Ensure_Audit_PNP_Activity_is_set_to_include_Success' do
  title "(L1) Ensure 'Audit PNP Activity' is set to include 'Success'"
  desc  "
    This policy setting allows you to audit when plug and play detects an external device.

    The recommended state for this setting is set to include: Success.

    **Note:** A Windows 10, Server 2016 or higher OS is required to access and set this value in Group Policy.

    Rationale: Enabling this setting will allow a user to audit events when a device is plugged into a system. This can help alert IT staff if unapproved devices are plugged in.
  "
  impact 1.0
  describe audit_policy do
    its('Plug and Play Events') { should match /Success/ }
  end
end

control '17.3.2_L1_Ensure_Audit_Process_Creation_is_set_to_include_Success' do
  title "(L1) Ensure 'Audit Process Creation' is set to include 'Success'"
  desc  "
    This subcategory reports the creation of a process and the name of the program or user that created it. Events for this subcategory include:

    * 4688: A new process has been created.
    * 4696: A primary token was assigned to process.
    Refer to Microsoft Knowledge Base article 947226: [Description of security events in Windows Vista and in Windows Server 2008](https://support.microsoft.com/en-us/kb/947226) for the most recent information about this setting.

    The recommended state for this setting is set to include: Success.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-33040-7'
  describe audit_policy do
    its('Process Creation') { should match /Success/ }
  end
end

control '17.5.1_L1_Ensure_Audit_Account_Lockout_is_set_to_include_Failure' do
  title "(L1) Ensure 'Audit Account Lockout' is set to include 'Failure'"
  desc  "
    This subcategory reports when a user's account is locked out as a result of too many failed logon attempts. Events for this subcategory include:

    * 4625: An account failed to log on.
    The recommended state for this setting is set to include: Failure.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35504-0'
  describe audit_policy do
    its('Account Lockout') { should match /Failure/ }
  end
end

control '17.5.2_L1_Ensure_Audit_Group_Membership_is_set_to_include_Success' do
  title "(L1) Ensure 'Audit Group Membership' is set to 'Success'"
  desc  "
    This policy allows you to audit the group membership information in the user#x2019;s logon token. Events in this subcategory are generated on the computer on which a logon session is created. For an interactive logon, the security audit event is generated on the computer that the user logged on to. For a network logon, such as accessing a shared folder on the network, the security audit event is generated on the computer hosting the resource.

    The recommended state for this setting is set to include: Success.

    **Note:** A Windows 10, Server 2016 or higher OS is required to access and set this value in Group Policy.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  describe audit_policy do
    its('Group Membership') { should match /Success/ }
  end
end

control '17.5.3_L1_Ensure_Audit_Logoff_is_set_to_include_Success' do
  title "(L1) Ensure 'Audit Logoff' is set to include 'Success'"
  desc  "
    This subcategory reports when a user logs off from the system. These events occur on the accessed computer. For interactive logons, the generation of these events occurs on the computer that is logged on to. If a network logon takes place to access a share, these events generate on the computer that hosts the accessed resource. If you configure this setting to No auditing, it is difficult or impossible to determine which user has accessed or attempted to access organization computers. Events for this subcategory include:

    * 4634: An account was logged off.
    * 4647: User initiated logoff.
    The recommended state for this setting is set to include: Success.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35507-3'
  describe audit_policy do
    its('Logoff') { should match /Success/ }
  end
end

control '17.5.4_L1_Ensure_Audit_Logon_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit Logon' is set to 'Success and Failure'"
  desc  "
    This subcategory reports when a user attempts to log on to the system. These events occur on the accessed computer. For interactive logons, the generation of these events occurs on the computer that is logged on to. If a network logon takes place to access a share, these events generate on the computer that hosts the accessed resource. If you configure this setting to No auditing, it is difficult or impossible to determine which user has accessed or attempted to access organization computers. Events for this subcategory include:

    * 4624: An account was successfully logged on.
    * 4625: An account failed to log on.
    * 4648: A logon was attempted using explicit credentials.
    * 4675: SIDs were filtered.
    The recommended state for this setting is: Success and Failure.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35508-1'
  describe audit_policy do
    its('Logon') { should eq 'Success and Failure' }
  end
end

control '17.5.5_L1_Ensure_Audit_Other_LogonLogoff_Events_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit Other Logon/Logoff Events' is set to 'Success and Failure'"
  desc  "
    This subcategory reports other logon/logoff-related events, such as Terminal Services session disconnects and reconnects, using RunAs to run processes under a different account, and locking and unlocking a workstation. Events for this subcategory include:

    * 4649: A replay attack was detected.
    * 4778: A session was reconnected to a Window Station.
    * 4779: A session was disconnected from a Window Station.
    * 4800: The workstation was locked.
    * 4801: The workstation was unlocked.
    * 4802: The screen saver was invoked.
    * 4803: The screen saver was dismissed.
    * 5378: The requested credentials delegation was disallowed by policy.
    * 5632: A request was made to authenticate to a wireless network.
    * 5633: A request was made to authenticate to a wired network.
    The recommended state for this setting is: Success and Failure.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35510-7'
  describe audit_policy do
    its('Other Logon/Logoff Events') { should eq 'Success and Failure' }
  end
end

control '17.5.6_L1_Ensure_Audit_Special_Logon_is_set_to_include_Success' do
  title "(L1) Ensure 'Audit Special Logon' is set to include 'Success'"
  desc  "
    This subcategory reports when a special logon is used. A special logon is a logon that has administrator-equivalent privileges and can be used to elevate a process to a higher level. Events for this subcategory include:

    * 4964 : Special groups have been assigned to a new logon.
    The recommended state for this setting is set to include: Success.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35511-5'
  describe audit_policy do
    its('Special Logon') { should match /Success/ }
  end
end

control '17.6.1_L1_Ensure_Audit_Detailed_File_Share_is_set_to_include_Failure' do
  title "(L1) Ensure 'Audit Detailed File Share' is set to include 'Failure'"
  desc  "
    This policy setting allows you to audit user attempts to access file system objects on a removable storage device. A security audit event is generated only for all objects for all types of access requested. If you configure this policy setting, an audit event is generated each time an account accesses a file system object on a removable storage. Success audits record successful attempts and Failure audits record unsuccessful attempts. If you do not configure this policy setting, no audit event is generated when an account accesses a file system object on a removable storage.

    The recommended state for this setting is set to include: Failure.
    **Note:** A Windows 8, Server 2012 (non-R2) or higher OS is required to access and set this value in Group Policy.

    Rationale: Auditing removable storage may be useful when investigating an incident. For example, if an individual is suspected of copying sensitive information onto a USB drive.
  "
  impact 1.0
  describe audit_policy do
    its('Detailed File Share') { should match /Failure/ }
  end
end

control '17.6.2_L1_Ensure_Audit_File_Share_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit File Share' is set to 'Success and Failure'"
  desc  "
    This policy setting allows you to audit user attempts to access file system objects on a removable storage device. A security audit event is generated only for all objects for all types of access requested. If you configure this policy setting, an audit event is generated each time an account accesses a file system object on a removable storage. Success audits record successful attempts and Failure audits record unsuccessful attempts. If you do not configure this policy setting, no audit event is generated when an account accesses a file system object on a removable storage.

    The recommended state for this setting is set to include: Failure.
    **Note:** A Windows 8, Server 2012 (non-R2) or higher OS is required to access and set this value in Group Policy.

    Rationale: Auditing removable storage may be useful when investigating an incident. For example, if an individual is suspected of copying sensitive information onto a USB drive.
  "
  impact 1.0
  describe audit_policy do
    its('File Share') { should eq 'Success and Failure' }
  end
end

control '17.6.3_L1_Ensure_Audit_Other_Object_Access_Events_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit Other Object Access Events' is set to 'Success and Failure'"
  desc  "
    This policy setting allows you to audit events generated by the management of task scheduler jobs or COM+ objects.
    For scheduler jobs, the following are audited:
    * Job created.
    * Job deleted.
    * Job enabled.
    * Job disabled.
    * Job updated.
    For COM+ objects, the following are audited:
    * Catalog object added.
    * Catalog object updated.
    * Catalog object deleted.
    The recommended state for this setting is: Success and Failure.
    Rationale: The unexpected creation of scheduled tasks and COM+ objects could potentially be an indication of malicious activity. Since these types of actions are generally low volume, it may be useful to capture them in the audit logs for use during an investigation.
  "
  impact 1.0
  tag cce: 'CCE-37620-2'
  describe audit_policy do
    its('Other Object Access Events') { should eq 'Success and Failure' }
  end
end

control '17.6.4_L1_Ensure_Audit_Removable_Storage_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit Removable Storage' is set to 'Success and Failure'"
  desc  "
    This policy setting allows you to audit user attempts to access file system objects on a removable storage device. A security audit event is generated only for all objects for all types of access requested. If you configure this policy setting, an audit event is generated each time an account accesses a file system object on a removable storage. Success audits record successful attempts and Failure audits record unsuccessful attempts. If you do not configure this policy setting, no audit event is generated when an account accesses a file system object on a removable storage.

    The recommended state for this setting is: Success and Failure.
    **Note:** A Windows 8, Server 2012 (non-R2) or higher OS is required to access and set this value in Group Policy.

    Rationale: Auditing removable storage may be useful when investigating an incident. For example, if an individual is suspected of copying sensitive information onto a USB drive.
  "
  impact 1.0
  tag cce: 'CCE-35520-6'
  describe audit_policy do
    its('Removable Storage') { should eq 'Success and Failure' }
  end
end

control '17.7.1_L1_Ensure_Audit_Audit_Policy_Change_is_set_to_include Success' do
  title "(L1) Ensure 'Audit Audit Policy Change' is set to include 'Success'"
  desc  "
    This subcategory reports changes in audit policy including SACL changes. Events for this subcategory include:

    * 4715: The audit policy (SACL) on an object was changed.
    * 4719: System audit policy was changed.
    * 4902: The Per-user audit policy table was created.
    * 4904: An attempt was made to register a security event source.
    * 4905: An attempt was made to unregister a security event source.
    * 4906: The CrashOnAuditFail value has changed.
    * 4907: Auditing settings on object were changed.
    * 4908: Special Groups Logon table modified.
    * 4912: Per User Audit Policy was changed.
    The recommended state for this setting is set to include: Success.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35521-4'
  describe audit_policy do
    its('Audit Policy Change') { should match /Success/ }
  end
end

control '17.7.2_L1_Ensure_Audit_Authentication_Policy_Change_is_set_to_include_Success' do
  title "(L1) Ensure 'Audit Authentication Policy Change' is set to include 'Success'"
  desc  "
    This subcategory reports changes in authentication policy. Events for this subcategory include:

    * 4706: A new trust was created to a domain.
    * 4707: A trust to a domain was removed.
    * 4713: Kerberos policy was changed.
    * 4716: Trusted domain information was modified.
    * 4717: System security access was granted to an account.
    * 4718: System security access was removed from an account.
    * 4739: Domain Policy was changed.
    * 4864: A namespace collision was detected.
    * 4865: A trusted forest information entry was added.
    * 4866: A trusted forest information entry was removed.
    * 4867: A trusted forest information entry was modified.
    The recommended state for this setting is set to include: Success.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-33091-0'
  describe audit_policy do
    its('Authentication Policy Change') { should match /Success/ }
  end
end

control '17.7.3_L1_Ensure_Audit_Authorization_Policy_Change_is_set_to_include_Success' do
  title "(L1) Ensure 'Audit Authorization Policy Change' is set to include 'Success'"
  desc  "
    This subcategory reports changes in authorization policy. Events for this subcategory include:
    * 4704: A user right was assigned.
    * 4705: A user right was removed.
    * 4706: A new trust was created to a domain.
    * 4707: A trust to a domain was removed.
    * 4714: Encrypted data recovery policy was changed.
    The recommended state for this setting is set to include: Success.
    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-36320-0'
  describe audit_policy do
    its('Authorization Policy Change') { should match /Success/ }
  end
end

control '17.7.4_L1_Ensure_Audit_MPSSVC_Rule-Level_Policy_Change_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit MPSSVC Rule-Level Policy Change' is set to 'Success and Failure'"
  desc  "
    This subcategory determines whether the operating system generates audit events when changes are made to policy rules for the Microsoft Protection Service (MPSSVC.exe). Events for this subcategory include:
    * 4944: The following policy was active when the Windows Firewall started.
    * 4945: A rule was listed when the Windows Firewall started.
    * 4946: A change has been made to Windows Firewall exception list. A rule was added.
    * 4947: A change has been made to Windows Firewall exception list. A rule was modified.
    * 4948: A change has been made to Windows Firewall exception list. A rule was deleted.
    * 4949: Windows Firewall settings were restored to the default values.
    * 4950: A Windows Firewall setting has changed.
    * 4951: A rule has been ignored because its major version number was not recognized by Windows Firewall.
    * 4952: Parts of a rule have been ignored because its minor version number was not recognized by Windows Firewall. The other parts of the rule will be enforced.
    * 4953: A rule has been ignored by Windows Firewall because it could not parse the rule.
    * 4954: Windows Firewall Group Policy settings have changed. The new settings have been applied.
    * 4956: Windows Firewall has changed the active profile.
    * 4957: Windows Firewall did not apply the following rule.
    * 4958: Windows Firewall did not apply the following rule because the rule referred to items not configured on this computer.
    The recommended state for this setting is : Success and Failure
  "
  impact 1.0
  describe audit_policy do
    its('MPSSVC Rule-Level Policy Change') { should eq 'Success and Failure' }
  end
end

control '17.7.5_L1_Ensure_Audit_Other_Policy_Change_Events_is_set_to_include_Failure' do
  title "(L1) Ensure 'Other Policy Change Events' is set to include 'Failure'"
  desc  "
    This subcategory contains events about EFS Data Recovery Agent policy changes, changes in Windows Filtering Platform filter, status on Security policy settings updates for local Group Policy settings, Central Access Policy changes, and detailed troubleshooting events for Cryptographic Next Generation (CNG) operations.
    * 5063: A cryptographic provider operation was attempted.
    * 5064: A cryptographic context operation was attempted.
    * 5065: A cryptographic context modification was attempted.
    * 5066: A cryptographic function operation was attempted.
    * 5067: A cryptographic function modification was attempted.
    * 5068: A cryptographic function provider operation was attempted.
    * 5069: A cryptographic function property operation was attempted.
    * 5070: A cryptographic function property modification was attempted.
    * 6145: One or more errors occurred while processing security policy in the group policy objects.
    The recommended state for this setting is to include: Failure.
  "
  impact 1.0
  describe audit_policy do
    its('Other Policy Change Events') { should match /Failure/ }
  end
end

control '17.8.1_L1_Ensure_Audit_Sensitive_Privilege_Use_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Sensitive Privilege Use' is set to 'Success and Failure'"
  desc  "
    This subcategory reports when a user account or service uses a sensitive privilege. A sensitive privilege includes the following user rights: Act as part of the operating system, Back up files and directories, Create a token object, Debug programs, Enable computer and user accounts to be trusted for delegation, Generate security audits, Impersonate a client after authentication, Load and unload device drivers, Manage auditing and security log, Modify firmware environment values, Replace a process-level token, Restore files and directories, and Take ownership of files or other objects. Auditing this subcategory will create a high volume of events. Events for this subcategory include:

    * 4672: Special privileges assigned to new logon.
    * 4673: A privileged service was called.
    * 4674: An operation was attempted on a privileged object.
    The recommended state for this setting is: Success and Failure.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35524-8'
  describe audit_policy do
    its('Sensitive Privilege Use') { should eq 'Success and Failure' }
  end
end

control '17.9.1_L1_Ensure_Audit_IPsec_Driver_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit IPsec Driver' is set to 'Success and Failure'"
  desc  "
    This subcategory reports on the activities of the Internet Protocol security (IPsec) driver. Events for this subcategory include:

    * 4960: IPsec dropped an inbound packet that failed an integrity check. If this problem persists, it could indicate a network issue or that packets are being modified in transit to this computer. Verify that the packets sent from the remote computer are the same as those received by this computer. This error might also indicate interoperability problems with other IPsec implementations.
    * 4961: IPsec dropped an inbound packet that failed a replay check. If this problem persists, it could indicate a replay attack against this computer.
    * 4962: IPsec dropped an inbound packet that failed a replay check. The inbound packet had too low a sequence number to ensure it was not a replay.
    * 4963: IPsec dropped an inbound clear text packet that should have been secured. This is usually due to the remote computer changing its IPsec policy without informing this computer. This could also be a spoofing attack attempt.
    * 4965: IPsec received a packet from a remote computer with an incorrect Security Parameter Index (SPI). This is usually caused by malfunctioning hardware that is corrupting packets. If these errors persist, verify that the packets sent from the remote computer are the same as those received by this computer. This error may also indicate interoperability problems with other IPsec implementations. In that case, if connectivity is not impeded, then these events can be ignored.
    * 5478: IPsec Services has started successfully.
    * 5479: IPsec Services has been shut down successfully. The shutdown of IPsec Services can put the computer at greater risk of network attack or expose the computer to potential security risks.
    * 5480: IPsec Services failed to get the complete list of network interfaces on the computer. This poses a potential security risk because some of the network interfaces may not get the protection provided by the applied IPsec filters. Use the IP Security Monitor snap-in to diagnose the problem.
    * 5483: IPsec Services failed to initialize RPC server. IPsec Services could not be started.
    * 5484: IPsec Services has experienced a critical failure and has been shut down. The shutdown of IPsec Services can put the computer at greater risk of network attack or expose the computer to potential security risks.
    * 5485: IPsec Services failed to process some IPsec filters on a plug-and-play event for network interfaces. This poses a potential security risk because some of the network interfaces may not get the protection provided by the applied IPsec filters. Use the IP Security Monitor snap-in to diagnose the problem.
    The recommended state for this setting is: Success and Failure.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35525-5'
  describe audit_policy do
    its('IPsec Driver') { should eq 'Success and Failure' }
  end
end

control '17.9.2_L1_Ensure_Audit_Other_System_Events_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit Other System Events' is set to 'Success and Failure'"
  desc  "
    This subcategory reports on other system events. Events for this subcategory include:

    * 5024 : The Windows Firewall Service has started successfully.
    * 5025 : The Windows Firewall Service has been stopped.
    * 5027 : The Windows Firewall Service was unable to retrieve the security policy from the local storage. The service will continue enforcing the current policy.
    * 5028 : The Windows Firewall Service was unable to parse the new security policy. The service will continue with currently enforced policy.
    * 5029: The Windows Firewall Service failed to initialize the driver. The service will continue to enforce the current policy.
    * 5030: The Windows Firewall Service failed to start.
    * 5032: Windows Firewall was unable to notify the user that it blocked an application from accepting incoming connections on the network.
    * 5033 : The Windows Firewall Driver has started successfully.
    * 5034 : The Windows Firewall Driver has been stopped.
    * 5035 : The Windows Firewall Driver failed to start.
    * 5037 : The Windows Firewall Driver detected critical runtime error. Terminating.
    * 5058: Key file operation.
    * 5059: Key migration operation.
    The recommended state for this setting is: Success and Failure.

    Rationale: Capturing these audit events may be useful for identifying when the Windows Firewall is not performing as expected.
  "
  impact 1.0
  tag cce: 'CCE-32936-7'
  describe audit_policy do
    its('Other System Events') { should eq 'Success and Failure' }
  end
end

control '17.9.3_L1_Ensure_Audit_Security_State_Change_is_set_to_include_Success' do
  title "(L1) Ensure 'Audit Security State Change' is set to include 'Success'"
  desc  "
    This subcategory reports changes in security state of the system, such as when the security subsystem starts and stops. Events for this subcategory include:

    * 4608: Windows is starting up.
    * 4609: Windows is shutting down.
    * 4616: The system time was changed.
    * 4621: Administrator recovered system from CrashOnAuditFail. Users who are not administrators will now be allowed to log on. Some audit-able activity might not have been recorded.
    The recommended state for this setting is set to include: Success.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-33043-1'
  describe audit_policy do
    its('Security State Change') { should match /Success/ }
  end
end

control '17.9.4_L1_Ensure_Audit_Security_System_Extension_is_set_to_include_Success' do
  title "(L1) Ensure 'Audit Security System Extension' is set to 'Success'"
  desc  "
    This subcategory reports the loading of extension code such as authentication packages by the security subsystem. Events for this subcategory include:

    * 4610: An authentication package has been loaded by the Local Security Authority.
    * 4611: A trusted logon process has been registered with the Local Security Authority.
    * 4614: A notification package has been loaded by the Security Account Manager.
    * 4622: A security package has been loaded by the Local Security Authority.
    * 4697: A service was installed in the system.
    The recommended state for this setting is set to include: Success.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35526-3'
  describe audit_policy do
    its('Security System Extension') { should match /Success/ }
  end
end

control '17.9.5_L1_Ensure_Audit_System_Integrity_is_set_to_Success_and_Failure' do
  title "(L1) Ensure 'Audit System Integrity' is set to 'Success and Failure'"
  desc  "
    This subcategory reports on violations of integrity of the security subsystem. Events for this subcategory include:

    * 4612 : Internal resources allocated for the queuing of audit messages have been exhausted, leading to the loss of some audits.
    * 4615 : Invalid use of LPC port.
    * 4618 : A monitored security event pattern has occurred.
    * 4816 : RPC detected an integrity violation while decrypting an incoming message.
    * 5038 : Code integrity determined that the image hash of a file is not valid. The file could be corrupt due to unauthorized modification or the invalid hash could indicate a potential disk device error.
    * 5056: A cryptographic self test was performed.
    * 5057: A cryptographic primitive operation failed.
    * 5060: Verification operation failed.
    * 5061: Cryptographic operation.
    * 5062: A kernel-mode cryptographic self test was performed.
    The recommended state for this setting is: Success and Failure.

    Rationale: Auditing these events may be useful when investigating a security incident.
  "
  impact 1.0
  tag cce: 'CCE-35527-1'
  describe audit_policy do
    its('System Integrity') { should eq 'Success and Failure' }
  end
end
