library security_hardening;

// Core security services
export 'src/services/security_hardener.dart';
export 'src/services/security_auditor.dart';
export 'src/services/vulnerability_scanner.dart';
export 'src/services/penetration_tester.dart';

// Security audit
export 'src/audit/code_security_auditor.dart';
export 'src/audit/dependency_auditor.dart';
export 'src/audit/configuration_auditor.dart';
export 'src/audit/network_auditor.dart';

// Vulnerability assessment
export 'src/vulnerability/owasp_scanner.dart';
export 'src/vulnerability/dependency_scanner.dart';
export 'src/vulnerability/configuration_scanner.dart';
export 'src/vulnerability/runtime_scanner.dart';

// Encryption enhancement
export 'src/encryption/encryption_manager.dart';
export 'src/encryption/key_manager.dart';
export 'src/encryption/certificate_manager.dart';
export 'src/encryption/hsm_integration.dart';

// Access control
export 'src/access/authentication_manager.dart';
export 'src/access/authorization_manager.dart';
export 'src/access/role_manager.dart';
export 'src/access/audit_logger.dart';

// Security monitoring
export 'src/monitoring/security_monitor.dart';
export 'src/monitoring/threat_detector.dart';
export 'src/monitoring/incident_responder.dart';
export 'src/monitoring/compliance_checker.dart';

// Data models
export 'src/models/security_config.dart';
export 'src/models/vulnerability_report.dart';
export 'src/models/security_incident.dart';
export 'src/models/compliance_report.dart';

// Utilities
export 'src/utils/security_utils.dart';
export 'src/utils/encryption_utils.dart';
export 'src/utils/audit_utils.dart';
