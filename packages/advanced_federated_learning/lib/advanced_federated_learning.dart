library advanced_federated_learning;

// Core federated learning services
export 'src/services/federated_learning_engine.dart';
export 'src/services/privacy_preserving_aggregator.dart';
export 'src/services/secure_aggregation.dart';
export 'src/services/differential_privacy_engine.dart';

// Privacy-preserving techniques
export 'src/privacy/homomorphic_encryption.dart';
export 'src/privacy/secure_multi_party_computation.dart';
export 'src/privacy/differential_privacy.dart';
export 'src/privacy/zero_knowledge_proofs.dart';

// Advanced learning algorithms
export 'src/algorithms/federated_averaging.dart';
export 'src/algorithms/federated_sgd.dart';
export 'src/algorithms/federated_proximal.dart';
export 'src/algorithms/personalized_federated_learning.dart';

// Communication protocols
export 'src/communication/federation_protocol.dart';
export 'src/communication/secure_channel.dart';
export 'src/communication/consensus_mechanism.dart';
export 'src/communication/gossip_protocol.dart';

// Data models
export 'src/models/federation_config.dart';
export 'src/models/learning_task.dart';
export 'src/models/model_update.dart';
export 'src/models/privacy_budget.dart';
export 'src/models/consensus_result.dart';

// Utilities
export 'src/utils/privacy_utils.dart';
export 'src/utils/encryption_utils.dart';
export 'src/utils/aggregation_utils.dart';
export 'src/utils/validation_utils.dart';
