//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: service.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Robotservice_RobotServiceClient`, then call methods of this protocol to make API calls.
internal protocol Robotservice_RobotServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Robotservice_RobotServiceClientInterceptorFactoryProtocol? { get }

  func getLocations(
    _ request: Robotservice_Empty,
    callOptions: CallOptions?
  ) -> UnaryCall<Robotservice_Empty, Robotservice_LocationList>

  func getRobots(
    _ request: Robotservice_Empty,
    callOptions: CallOptions?
  ) -> UnaryCall<Robotservice_Empty, Robotservice_RobotList>

  func getQueue(
    _ request: Robotservice_Empty,
    callOptions: CallOptions?
  ) -> UnaryCall<Robotservice_Empty, Robotservice_QueueList>

  func callRobot(
    _ request: Robotservice_CallRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Robotservice_CallRequest, Robotservice_CallResponse>

  func cancelCall(
    _ request: Robotservice_CancelRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Robotservice_CancelRequest, Robotservice_CancelResponse>
}

extension Robotservice_RobotServiceClientProtocol {
  internal var serviceName: String {
    return "robotservice.RobotService"
  }

  /// Unary call to GetLocations
  ///
  /// - Parameters:
  ///   - request: Request to send to GetLocations.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getLocations(
    _ request: Robotservice_Empty,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Robotservice_Empty, Robotservice_LocationList> {
    return self.makeUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.getLocations.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetLocationsInterceptors() ?? []
    )
  }

  /// Unary call to GetRobots
  ///
  /// - Parameters:
  ///   - request: Request to send to GetRobots.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getRobots(
    _ request: Robotservice_Empty,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Robotservice_Empty, Robotservice_RobotList> {
    return self.makeUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.getRobots.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetRobotsInterceptors() ?? []
    )
  }

  /// Unary call to GetQueue
  ///
  /// - Parameters:
  ///   - request: Request to send to GetQueue.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getQueue(
    _ request: Robotservice_Empty,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Robotservice_Empty, Robotservice_QueueList> {
    return self.makeUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.getQueue.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetQueueInterceptors() ?? []
    )
  }

  /// Unary call to CallRobot
  ///
  /// - Parameters:
  ///   - request: Request to send to CallRobot.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func callRobot(
    _ request: Robotservice_CallRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Robotservice_CallRequest, Robotservice_CallResponse> {
    return self.makeUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.callRobot.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeCallRobotInterceptors() ?? []
    )
  }

  /// Unary call to CancelCall
  ///
  /// - Parameters:
  ///   - request: Request to send to CancelCall.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func cancelCall(
    _ request: Robotservice_CancelRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Robotservice_CancelRequest, Robotservice_CancelResponse> {
    return self.makeUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.cancelCall.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeCancelCallInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension Robotservice_RobotServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Robotservice_RobotServiceNIOClient")
internal final class Robotservice_RobotServiceClient: Robotservice_RobotServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Robotservice_RobotServiceClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: Robotservice_RobotServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the robotservice.RobotService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Robotservice_RobotServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct Robotservice_RobotServiceNIOClient: Robotservice_RobotServiceClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Robotservice_RobotServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the robotservice.RobotService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Robotservice_RobotServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Robotservice_RobotServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Robotservice_RobotServiceClientInterceptorFactoryProtocol? { get }

  func makeGetLocationsCall(
    _ request: Robotservice_Empty,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Robotservice_Empty, Robotservice_LocationList>

  func makeGetRobotsCall(
    _ request: Robotservice_Empty,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Robotservice_Empty, Robotservice_RobotList>

  func makeGetQueueCall(
    _ request: Robotservice_Empty,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Robotservice_Empty, Robotservice_QueueList>

  func makeCallRobotCall(
    _ request: Robotservice_CallRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Robotservice_CallRequest, Robotservice_CallResponse>

  func makeCancelCallCall(
    _ request: Robotservice_CancelRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Robotservice_CancelRequest, Robotservice_CancelResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Robotservice_RobotServiceAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Robotservice_RobotServiceClientMetadata.serviceDescriptor
  }

  internal var interceptors: Robotservice_RobotServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeGetLocationsCall(
    _ request: Robotservice_Empty,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Robotservice_Empty, Robotservice_LocationList> {
    return self.makeAsyncUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.getLocations.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetLocationsInterceptors() ?? []
    )
  }

  internal func makeGetRobotsCall(
    _ request: Robotservice_Empty,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Robotservice_Empty, Robotservice_RobotList> {
    return self.makeAsyncUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.getRobots.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetRobotsInterceptors() ?? []
    )
  }

  internal func makeGetQueueCall(
    _ request: Robotservice_Empty,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Robotservice_Empty, Robotservice_QueueList> {
    return self.makeAsyncUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.getQueue.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetQueueInterceptors() ?? []
    )
  }

  internal func makeCallRobotCall(
    _ request: Robotservice_CallRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Robotservice_CallRequest, Robotservice_CallResponse> {
    return self.makeAsyncUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.callRobot.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeCallRobotInterceptors() ?? []
    )
  }

  internal func makeCancelCallCall(
    _ request: Robotservice_CancelRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Robotservice_CancelRequest, Robotservice_CancelResponse> {
    return self.makeAsyncUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.cancelCall.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeCancelCallInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Robotservice_RobotServiceAsyncClientProtocol {
  internal func getLocations(
    _ request: Robotservice_Empty,
    callOptions: CallOptions? = nil
  ) async throws -> Robotservice_LocationList {
    return try await self.performAsyncUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.getLocations.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetLocationsInterceptors() ?? []
    )
  }

  internal func getRobots(
    _ request: Robotservice_Empty,
    callOptions: CallOptions? = nil
  ) async throws -> Robotservice_RobotList {
    return try await self.performAsyncUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.getRobots.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetRobotsInterceptors() ?? []
    )
  }

  internal func getQueue(
    _ request: Robotservice_Empty,
    callOptions: CallOptions? = nil
  ) async throws -> Robotservice_QueueList {
    return try await self.performAsyncUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.getQueue.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetQueueInterceptors() ?? []
    )
  }

  internal func callRobot(
    _ request: Robotservice_CallRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Robotservice_CallResponse {
    return try await self.performAsyncUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.callRobot.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeCallRobotInterceptors() ?? []
    )
  }

  internal func cancelCall(
    _ request: Robotservice_CancelRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Robotservice_CancelResponse {
    return try await self.performAsyncUnaryCall(
      path: Robotservice_RobotServiceClientMetadata.Methods.cancelCall.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeCancelCallInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct Robotservice_RobotServiceAsyncClient: Robotservice_RobotServiceAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Robotservice_RobotServiceClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Robotservice_RobotServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol Robotservice_RobotServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'getLocations'.
  func makeGetLocationsInterceptors() -> [ClientInterceptor<Robotservice_Empty, Robotservice_LocationList>]

  /// - Returns: Interceptors to use when invoking 'getRobots'.
  func makeGetRobotsInterceptors() -> [ClientInterceptor<Robotservice_Empty, Robotservice_RobotList>]

  /// - Returns: Interceptors to use when invoking 'getQueue'.
  func makeGetQueueInterceptors() -> [ClientInterceptor<Robotservice_Empty, Robotservice_QueueList>]

  /// - Returns: Interceptors to use when invoking 'callRobot'.
  func makeCallRobotInterceptors() -> [ClientInterceptor<Robotservice_CallRequest, Robotservice_CallResponse>]

  /// - Returns: Interceptors to use when invoking 'cancelCall'.
  func makeCancelCallInterceptors() -> [ClientInterceptor<Robotservice_CancelRequest, Robotservice_CancelResponse>]
}

internal enum Robotservice_RobotServiceClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "RobotService",
    fullName: "robotservice.RobotService",
    methods: [
      Robotservice_RobotServiceClientMetadata.Methods.getLocations,
      Robotservice_RobotServiceClientMetadata.Methods.getRobots,
      Robotservice_RobotServiceClientMetadata.Methods.getQueue,
      Robotservice_RobotServiceClientMetadata.Methods.callRobot,
      Robotservice_RobotServiceClientMetadata.Methods.cancelCall,
    ]
  )

  internal enum Methods {
    internal static let getLocations = GRPCMethodDescriptor(
      name: "GetLocations",
      path: "/robotservice.RobotService/GetLocations",
      type: GRPCCallType.unary
    )

    internal static let getRobots = GRPCMethodDescriptor(
      name: "GetRobots",
      path: "/robotservice.RobotService/GetRobots",
      type: GRPCCallType.unary
    )

    internal static let getQueue = GRPCMethodDescriptor(
      name: "GetQueue",
      path: "/robotservice.RobotService/GetQueue",
      type: GRPCCallType.unary
    )

    internal static let callRobot = GRPCMethodDescriptor(
      name: "CallRobot",
      path: "/robotservice.RobotService/CallRobot",
      type: GRPCCallType.unary
    )

    internal static let cancelCall = GRPCMethodDescriptor(
      name: "CancelCall",
      path: "/robotservice.RobotService/CancelCall",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Robotservice_RobotServiceProvider: CallHandlerProvider {
  var interceptors: Robotservice_RobotServiceServerInterceptorFactoryProtocol? { get }

  func getLocations(request: Robotservice_Empty, context: StatusOnlyCallContext) -> EventLoopFuture<Robotservice_LocationList>

  func getRobots(request: Robotservice_Empty, context: StatusOnlyCallContext) -> EventLoopFuture<Robotservice_RobotList>

  func getQueue(request: Robotservice_Empty, context: StatusOnlyCallContext) -> EventLoopFuture<Robotservice_QueueList>

  func callRobot(request: Robotservice_CallRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Robotservice_CallResponse>

  func cancelCall(request: Robotservice_CancelRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Robotservice_CancelResponse>
}

extension Robotservice_RobotServiceProvider {
  internal var serviceName: Substring {
    return Robotservice_RobotServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetLocations":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Robotservice_Empty>(),
        responseSerializer: ProtobufSerializer<Robotservice_LocationList>(),
        interceptors: self.interceptors?.makeGetLocationsInterceptors() ?? [],
        userFunction: self.getLocations(request:context:)
      )

    case "GetRobots":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Robotservice_Empty>(),
        responseSerializer: ProtobufSerializer<Robotservice_RobotList>(),
        interceptors: self.interceptors?.makeGetRobotsInterceptors() ?? [],
        userFunction: self.getRobots(request:context:)
      )

    case "GetQueue":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Robotservice_Empty>(),
        responseSerializer: ProtobufSerializer<Robotservice_QueueList>(),
        interceptors: self.interceptors?.makeGetQueueInterceptors() ?? [],
        userFunction: self.getQueue(request:context:)
      )

    case "CallRobot":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Robotservice_CallRequest>(),
        responseSerializer: ProtobufSerializer<Robotservice_CallResponse>(),
        interceptors: self.interceptors?.makeCallRobotInterceptors() ?? [],
        userFunction: self.callRobot(request:context:)
      )

    case "CancelCall":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Robotservice_CancelRequest>(),
        responseSerializer: ProtobufSerializer<Robotservice_CancelResponse>(),
        interceptors: self.interceptors?.makeCancelCallInterceptors() ?? [],
        userFunction: self.cancelCall(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Robotservice_RobotServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Robotservice_RobotServiceServerInterceptorFactoryProtocol? { get }

  func getLocations(
    request: Robotservice_Empty,
    context: GRPCAsyncServerCallContext
  ) async throws -> Robotservice_LocationList

  func getRobots(
    request: Robotservice_Empty,
    context: GRPCAsyncServerCallContext
  ) async throws -> Robotservice_RobotList

  func getQueue(
    request: Robotservice_Empty,
    context: GRPCAsyncServerCallContext
  ) async throws -> Robotservice_QueueList

  func callRobot(
    request: Robotservice_CallRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Robotservice_CallResponse

  func cancelCall(
    request: Robotservice_CancelRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Robotservice_CancelResponse
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Robotservice_RobotServiceAsyncProvider {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Robotservice_RobotServiceServerMetadata.serviceDescriptor
  }

  internal var serviceName: Substring {
    return Robotservice_RobotServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  internal var interceptors: Robotservice_RobotServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetLocations":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Robotservice_Empty>(),
        responseSerializer: ProtobufSerializer<Robotservice_LocationList>(),
        interceptors: self.interceptors?.makeGetLocationsInterceptors() ?? [],
        wrapping: { try await self.getLocations(request: $0, context: $1) }
      )

    case "GetRobots":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Robotservice_Empty>(),
        responseSerializer: ProtobufSerializer<Robotservice_RobotList>(),
        interceptors: self.interceptors?.makeGetRobotsInterceptors() ?? [],
        wrapping: { try await self.getRobots(request: $0, context: $1) }
      )

    case "GetQueue":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Robotservice_Empty>(),
        responseSerializer: ProtobufSerializer<Robotservice_QueueList>(),
        interceptors: self.interceptors?.makeGetQueueInterceptors() ?? [],
        wrapping: { try await self.getQueue(request: $0, context: $1) }
      )

    case "CallRobot":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Robotservice_CallRequest>(),
        responseSerializer: ProtobufSerializer<Robotservice_CallResponse>(),
        interceptors: self.interceptors?.makeCallRobotInterceptors() ?? [],
        wrapping: { try await self.callRobot(request: $0, context: $1) }
      )

    case "CancelCall":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Robotservice_CancelRequest>(),
        responseSerializer: ProtobufSerializer<Robotservice_CancelResponse>(),
        interceptors: self.interceptors?.makeCancelCallInterceptors() ?? [],
        wrapping: { try await self.cancelCall(request: $0, context: $1) }
      )

    default:
      return nil
    }
  }
}

internal protocol Robotservice_RobotServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'getLocations'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetLocationsInterceptors() -> [ServerInterceptor<Robotservice_Empty, Robotservice_LocationList>]

  /// - Returns: Interceptors to use when handling 'getRobots'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetRobotsInterceptors() -> [ServerInterceptor<Robotservice_Empty, Robotservice_RobotList>]

  /// - Returns: Interceptors to use when handling 'getQueue'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetQueueInterceptors() -> [ServerInterceptor<Robotservice_Empty, Robotservice_QueueList>]

  /// - Returns: Interceptors to use when handling 'callRobot'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeCallRobotInterceptors() -> [ServerInterceptor<Robotservice_CallRequest, Robotservice_CallResponse>]

  /// - Returns: Interceptors to use when handling 'cancelCall'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeCancelCallInterceptors() -> [ServerInterceptor<Robotservice_CancelRequest, Robotservice_CancelResponse>]
}

internal enum Robotservice_RobotServiceServerMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "RobotService",
    fullName: "robotservice.RobotService",
    methods: [
      Robotservice_RobotServiceServerMetadata.Methods.getLocations,
      Robotservice_RobotServiceServerMetadata.Methods.getRobots,
      Robotservice_RobotServiceServerMetadata.Methods.getQueue,
      Robotservice_RobotServiceServerMetadata.Methods.callRobot,
      Robotservice_RobotServiceServerMetadata.Methods.cancelCall,
    ]
  )

  internal enum Methods {
    internal static let getLocations = GRPCMethodDescriptor(
      name: "GetLocations",
      path: "/robotservice.RobotService/GetLocations",
      type: GRPCCallType.unary
    )

    internal static let getRobots = GRPCMethodDescriptor(
      name: "GetRobots",
      path: "/robotservice.RobotService/GetRobots",
      type: GRPCCallType.unary
    )

    internal static let getQueue = GRPCMethodDescriptor(
      name: "GetQueue",
      path: "/robotservice.RobotService/GetQueue",
      type: GRPCCallType.unary
    )

    internal static let callRobot = GRPCMethodDescriptor(
      name: "CallRobot",
      path: "/robotservice.RobotService/CallRobot",
      type: GRPCCallType.unary
    )

    internal static let cancelCall = GRPCMethodDescriptor(
      name: "CancelCall",
      path: "/robotservice.RobotService/CancelCall",
      type: GRPCCallType.unary
    )
  }
}
