library federated_learning;

// Core federated learning services
export 'src/services/federated_learner.dart';
export 'src/services/privacy_preserver.dart';
export 'src/services/secure_aggregator.dart';
export 'src/services/model_synchronizer.dart';

// Privacy-preserving techniques
export 'src/privacy/differential_privacy.dart';
export 'src/privacy/secure_aggregation.dart';
export 'src/privacy/homomorphic_encryption.dart';
export 'src/privacy/zero_knowledge_proofs.dart';

// Model management
export 'src/models/local_model.dart';
export 'src/models/global_model.dart';
export 'src/models/model_update.dart';
export 'src/models/training_data.dart';

// Communication
export 'src/communication/federation_client.dart';
export 'src/communication/federation_server.dart';
export 'src/communication/secure_channel.dart';

// Training
export 'src/training/local_trainer.dart';
export 'src/training/global_trainer.dart';
export 'src/training/training_coordinator.dart';

// Utilities
export 'src/utils/federated_utils.dart';
export 'src/utils/privacy_utils.dart';
export 'src/utils/encryption_utils.dart';
