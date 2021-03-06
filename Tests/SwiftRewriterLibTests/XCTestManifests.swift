#if !canImport(ObjectiveC)
import XCTest

extension ASTRewriterPassTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ASTRewriterPassTests = [
        ("testTraverseDeepNestedBlockStatement", testTraverseDeepNestedBlockStatement),
        ("testTraverseStatement", testTraverseStatement),
        ("testTraverseThroughPostfixFunctionArgument", testTraverseThroughPostfixFunctionArgument),
        ("testTraverseThroughPostfixSubscriptArgument", testTraverseThroughPostfixSubscriptArgument),
    ]
}

extension IntentionCollectorTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__IntentionCollectorTests = [
        ("testCollectFunctionDefinition", testCollectFunctionDefinition),
        ("testCollectFunctionDefinitionBody", testCollectFunctionDefinitionBody),
        ("testCollectPropertyIBInspectableAttribute", testCollectPropertyIBInspectableAttribute),
        ("testCollectPropertyIBOutletAttribute", testCollectPropertyIBOutletAttribute),
    ]
}

extension PropertyMergeIntentionPassTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PropertyMergeIntentionPassTests = [
        ("testCollapsePropertiesAndMethods", testCollapsePropertiesAndMethods),
        ("testCollapsePropertiesAndMethodsWithTypeSignatureMatching", testCollapsePropertiesAndMethodsWithTypeSignatureMatching),
        ("testPassWithGetter", testPassWithGetter),
        ("testPassWithGetterAndSetter", testPassWithGetterAndSetter),
        ("testPassWithGetterAndSetterWithSynthesizedField", testPassWithGetterAndSetterWithSynthesizedField),
        ("testSetterOnly", testSetterOnly),
    ]
}

extension SwiftASTReaderContextTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftASTReaderContextTests = [
        ("testTypePropertyOrFieldNamedWithField", testTypePropertyOrFieldNamedWithField),
        ("testTypePropertyOrFieldNamedWithProperty", testTypePropertyOrFieldNamedWithProperty),
    ]
}

extension SwiftExprASTReaderTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftExprASTReaderTests = [
        ("testArrayLiteral", testArrayLiteral),
        ("testAssignmentWithMethodCall", testAssignmentWithMethodCall),
        ("testBinaryOperator", testBinaryOperator),
        ("testBlockExpression", testBlockExpression),
        ("testBlockMultiExpression", testBlockMultiExpression),
        ("testCastExpression", testCastExpression),
        ("testConstants", testConstants),
        ("testDictionaryLiteral", testDictionaryLiteral),
        ("testFunctionCall", testFunctionCall),
        ("testMemberAccess", testMemberAccess),
        ("testNestedCompoundStatementInExpression", testNestedCompoundStatementInExpression),
        ("testParensExpression", testParensExpression),
        ("testPostfixIncrementDecrement", testPostfixIncrementDecrement),
        ("testPostfixStructAccessWithAssignment", testPostfixStructAccessWithAssignment),
        ("testRangeExpression", testRangeExpression),
        ("testSelectorExpression", testSelectorExpression),
        ("testSelectorMessage", testSelectorMessage),
        ("testSubscript", testSubscript),
        ("testTernaryExpression", testTernaryExpression),
    ]
}

extension SwiftMethodSignatureGenTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftMethodSignatureGenTests = [
        ("testAbcdReturnlessSelectorlessTypelessSignature", testAbcdReturnlessSelectorlessTypelessSignature),
        ("testAbcdSelectorlessTypelessSignature", testAbcdSelectorlessTypelessSignature),
        ("testCompactReturnlessSelectorlessTypelessSignature", testCompactReturnlessSelectorlessTypelessSignature),
        ("testInitializer", testInitializer),
        ("testLabellessArgument", testLabellessArgument),
        ("testReturnType", testReturnType),
        ("testSelectorLessArguments", testSelectorLessArguments),
        ("testSimpleMultiArguments", testSimpleMultiArguments),
        ("testSimpleSingleArgument", testSimpleSingleArgument),
        ("testSimpleVoidDefinition", testSimpleVoidDefinition),
    ]
}

extension SwiftOperatorTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftOperatorTests = [
        ("testOperatorCategoryArithmetic", testOperatorCategoryArithmetic),
        ("testOperatorCategoryAssignment", testOperatorCategoryAssignment),
        ("testOperatorCategoryComparison", testOperatorCategoryComparison),
        ("testOperatorCategoryLogical", testOperatorCategoryLogical),
        ("testOperatorCategoryNullCoalesce", testOperatorCategoryNullCoalesce),
        ("testOperatorCategoryRangeMaking", testOperatorCategoryRangeMaking),
    ]
}

extension SwiftRewriterJobTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriterJobTests = [
        ("testTranspile", testTranspile),
    ]
}

extension SwiftRewriterNullabilityTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriterNullabilityTests = [
        ("testNilInitialValueWithSubsequentNonNilAssignment", testNilInitialValueWithSubsequentNonNilAssignment),
        ("testNonNilInitializedImplicitUnwrappedVariableKeepsNullabilityInCaseNilIsAssignedLater", testNonNilInitializedImplicitUnwrappedVariableKeepsNullabilityInCaseNilIsAssignedLater),
    ]
}

extension SwiftRewriterTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriterTests = [
        ("testAddNullCoalesceToCompletionBlockInvocationsDeepIntoBlockExpressions", testAddNullCoalesceToCompletionBlockInvocationsDeepIntoBlockExpressions),
        ("testAppliesTypenameConversionToCategories", testAppliesTypenameConversionToCategories),
        ("testApplyCastOnNumericalVariableDeclarationInits", testApplyCastOnNumericalVariableDeclarationInits),
        ("testApplyIntegerCastOnTypealiasedPropertyInVariableDeclaration", testApplyIntegerCastOnTypealiasedPropertyInVariableDeclaration),
        ("testApplyNilCoalesceInDeeplyNestedExpressionsProperly", testApplyNilCoalesceInDeeplyNestedExpressionsProperly),
        ("testAutomaticIfLetPatternSimple", testAutomaticIfLetPatternSimple),
        ("testBackingFieldAnalysisForSynthesizedPropertyIsIgnoredIfSynthesizedNameMatchesPropertyName", testBackingFieldAnalysisForSynthesizedPropertyIsIgnoredIfSynthesizedNameMatchesPropertyName),
        ("testBackingFieldUsageAnalysisWithSynthesizedBackingFieldIsOrderIndependent", testBackingFieldUsageAnalysisWithSynthesizedBackingFieldIsOrderIndependent),
        ("testBlockTypeDefinitionsDefaultToOptionalReferenceTypes", testBlockTypeDefinitionsDefaultToOptionalReferenceTypes),
        ("testCollapsePropertySynthesisWhenPropertyAndBackingFieldMatchTypesAndName", testCollapsePropertySynthesisWhenPropertyAndBackingFieldMatchTypesAndName),
        ("testConvertAssignProperty", testConvertAssignProperty),
        ("testConvertImplementationAndCallSiteUsingKnownTypeInformation", testConvertImplementationAndCallSiteUsingKnownTypeInformation),
        ("testCorrectsDateIsEqualIntoBinaryExpression", testCorrectsDateIsEqualIntoBinaryExpression),
        ("testCorrectsNullabilityOfMethodParameters", testCorrectsNullabilityOfMethodParameters),
        ("testCorrectsNullableArgumentInFoundationTypeFunctionCall", testCorrectsNullableArgumentInFoundationTypeFunctionCall),
        ("testDateClassGetterCase", testDateClassGetterCase),
        ("testDetectBooleanGettersInUIViewSubclasses", testDetectBooleanGettersInUIViewSubclasses),
        ("testDontMarkProtocolImplementationsAsOverride", testDontMarkProtocolImplementationsAsOverride),
        ("testDontOmitObjcAttributeOnNSObjectProtocolInheritingProtocols", testDontOmitObjcAttributeOnNSObjectProtocolInheritingProtocols),
        ("testDontSynthesizeDynamicDeclaration", testDontSynthesizeDynamicDeclaration),
        ("testEmitObjcAttribute", testEmitObjcAttribute),
        ("testEnumAccessRewriting", testEnumAccessRewriting),
        ("testFloorMethodRecastingIssue", testFloorMethodRecastingIssue),
        ("testFunctionParameterTakesPrecedenceOverPropertyDuringDefinitionLookup", testFunctionParameterTakesPrecedenceOverPropertyDuringDefinitionLookup),
        ("testIfFalseDirectivesHideCodeWithin", testIfFalseDirectivesHideCodeWithin),
        ("testInstanceTypeOnStaticConstructor", testInstanceTypeOnStaticConstructor),
        ("testKeepPreprocessorDirectives", testKeepPreprocessorDirectives),
        ("testLazyTypeResolveFuncDeclaration", testLazyTypeResolveFuncDeclaration),
        ("testMarkOverrideIfSuperCallIsDetected", testMarkOverrideIfSuperCallIsDetected),
        ("testMarksOverrideBasedOnTypeLookup", testMarksOverrideBasedOnTypeLookup),
        ("testMergeNullabilityOfAliasedBlockFromNonAliasedDeclaration", testMergeNullabilityOfAliasedBlockFromNonAliasedDeclaration),
        ("testMergeNullabilityOfTypealiasedBlockType", testMergeNullabilityOfTypealiasedBlockType),
        ("testNSAssumeNonnullContextCollectionWorksWithCompilerDirectivesInFile", testNSAssumeNonnullContextCollectionWorksWithCompilerDirectivesInFile),
        ("testNullCoalesceInChainedValueTypePostfix", testNullCoalesceInChainedValueTypePostfix),
        ("testOptionalCoalesceNullableStructAccess", testOptionalCoalesceNullableStructAccess),
        ("testOptionalInAssignmentLeftHandSide", testOptionalInAssignmentLeftHandSide),
        ("testParseAliasedTypealias", testParseAliasedTypealias),
        ("testParseNonnullMacros", testParseNonnullMacros),
        ("testParsingKeepsOrderingOfStatementsAndDeclarations", testParsingKeepsOrderingOfStatementsAndDeclarations),
        ("testPostfixAfterCastOnSubscriptionUsesOptionalPostfix", testPostfixAfterCastOnSubscriptionUsesOptionalPostfix),
        ("testPostfixAfterCastUsesOptionalPostfix", testPostfixAfterCastUsesOptionalPostfix),
        ("testPropagateNullabilityOfBlockArgumentsInTypealiasedBlock", testPropagateNullabilityOfBlockArgumentsInTypealiasedBlock),
        ("testReadOnlyPropertyWithBackingFieldWithSameNameGetsCollapedAsPrivateSetProperty", testReadOnlyPropertyWithBackingFieldWithSameNameGetsCollapedAsPrivateSetProperty),
        ("testRewriteAliasedTypedefStruct", testRewriteAliasedTypedefStruct),
        ("testRewriteAliasedTypedefStructWithPointers", testRewriteAliasedTypedefStructWithPointers),
        ("testRewriteBlockIvars", testRewriteBlockIvars),
        ("testRewriteBlockParameters", testRewriteBlockParameters),
        ("testRewriteBlockTypeDef", testRewriteBlockTypeDef),
        ("testRewriteBlockTypeDefWithVoidParameterList", testRewriteBlockTypeDefWithVoidParameterList),
        ("testRewriteBlockWithinBlocksIvars", testRewriteBlockWithinBlocksIvars),
        ("testRewriteCFunctionPointerTypeDef", testRewriteCFunctionPointerTypeDef),
        ("testRewriteChainedSubscriptAccess", testRewriteChainedSubscriptAccess),
        ("testRewriteClassProperties", testRewriteClassProperties),
        ("testRewriteClassProperty", testRewriteClassProperty),
        ("testRewriteClassThatImplementsProtocolOverridesSignatureNullabilityOnImplementation", testRewriteClassThatImplementsProtocolOverridesSignatureNullabilityOnImplementation),
        ("testRewriteDeallocMethod", testRewriteDeallocMethod),
        ("testRewriteDelegatedInitializer", testRewriteDelegatedInitializer),
        ("testRewriteDetectedFailableInit", testRewriteDetectedFailableInit),
        ("testRewriteEmptyClass", testRewriteEmptyClass),
        ("testRewriteEmptyClassMethod", testRewriteEmptyClassMethod),
        ("testRewriteEmptyMethod", testRewriteEmptyMethod),
        ("testRewriteEnumDeclaration", testRewriteEnumDeclaration),
        ("testRewriteExplicitFailableInit", testRewriteExplicitFailableInit),
        ("testRewriteFreeStruct", testRewriteFreeStruct),
        ("testRewriteFuncDeclaration", testRewriteFuncDeclaration),
        ("testRewriteGenericSuperclass", testRewriteGenericSuperclass),
        ("testRewriteGenericsWithinGenerics", testRewriteGenericsWithinGenerics),
        ("testRewriteGlobalVariableDeclaration", testRewriteGlobalVariableDeclaration),
        ("testRewriteGlobalVariableDeclarationWithInitialValue", testRewriteGlobalVariableDeclarationWithInitialValue),
        ("testRewriteIBInspectable", testRewriteIBInspectable),
        ("testRewriteIBOutlet", testRewriteIBOutlet),
        ("testRewriteIfElseIfElse", testRewriteIfElseIfElse),
        ("testRewriteInfersNSObjectSuperclass", testRewriteInfersNSObjectSuperclass),
        ("testRewriteInheritance", testRewriteInheritance),
        ("testRewriteInitBody", testRewriteInitBody),
        ("testRewriteInitMethods", testRewriteInitMethods),
        ("testRewriteInstanceVariables", testRewriteInstanceVariables),
        ("testRewriteInterfaceWithCategoryWithImplementation", testRewriteInterfaceWithCategoryWithImplementation),
        ("testRewriteInterfaceWithImplementation", testRewriteInterfaceWithImplementation),
        ("testRewriteInterfaceWithImplementationPerformsSelectorMatchingIgnoringArgumentNames", testRewriteInterfaceWithImplementationPerformsSelectorMatchingIgnoringArgumentNames),
        ("testRewriteIVarBetweenAssumeNonNulls", testRewriteIVarBetweenAssumeNonNulls),
        ("testRewriteIVarsWithAccessControls", testRewriteIVarsWithAccessControls),
        ("testRewriteLocalFunctionPointerDeclaration", testRewriteLocalFunctionPointerDeclaration),
        ("testRewriteManyTypeliasSequentially", testRewriteManyTypeliasSequentially),
        ("testRewriteMethodSignatures", testRewriteMethodSignatures),
        ("testRewriteNSArray", testRewriteNSArray),
        ("testRewriteOpaqueTypealias", testRewriteOpaqueTypealias),
        ("testRewriteProtocol", testRewriteProtocol),
        ("testRewriteProtocolConformance", testRewriteProtocolConformance),
        ("testRewriteProtocolOptionalRequiredSections", testRewriteProtocolOptionalRequiredSections),
        ("testRewriteProtocolPropertiesWithGetSetSpecifiers", testRewriteProtocolPropertiesWithGetSetSpecifiers),
        ("testRewriteProtocolSpecification", testRewriteProtocolSpecification),
        ("testRewriterMergesNonnullMacrosForNullabilityInferring", testRewriterMergesNonnullMacrosForNullabilityInferring),
        ("testRewriterPointerToStructTypeDef", testRewriterPointerToStructTypeDef),
        ("testRewriterSynthesizesBackingFieldOnReadonlyPropertyIfAnUsageIsDetected", testRewriterSynthesizesBackingFieldOnReadonlyPropertyIfAnUsageIsDetected),
        ("testRewriterUsesNonnullMacrosForNullabilityInferring", testRewriterUsesNonnullMacrosForNullabilityInferring),
        ("testRewriteSelectorExpression", testRewriteSelectorExpression),
        ("testRewriteSignatureContainingWithKeyword", testRewriteSignatureContainingWithKeyword),
        ("testRewritesNew", testRewritesNew),
        ("testRewriteStaticConstantValuesInClass", testRewriteStaticConstantValuesInClass),
        ("testRewriteStructTypedefs", testRewriteStructTypedefs),
        ("testRewriteSubclassInInterface", testRewriteSubclassInInterface),
        ("testRewriteWeakProperty", testRewriteWeakProperty),
        ("testScalarTypeStoredPropertiesAlwaysInitializeAtZero", testScalarTypeStoredPropertiesAlwaysInitializeAtZero),
        ("testSynthesizePropertyBackingField", testSynthesizePropertyBackingField),
        ("testSynthesizeReadonlyPropertyBackingField", testSynthesizeReadonlyPropertyBackingField),
        ("testSynthesizeReadonlyPropertyOnExistingIVar", testSynthesizeReadonlyPropertyOnExistingIVar),
        ("testWhenRewritingMethodsSignaturesWithNullabilityOverrideSignaturesWithout", testWhenRewritingMethodsSignaturesWithNullabilityOverrideSignaturesWithout),
    ]
}

extension SwiftRewriterTests_Crashers {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriterTests_Crashers = [
        ("testCrashInSwitchCaseWithCompoundStatement", testCrashInSwitchCaseWithCompoundStatement),
    ]
}

extension SwiftRewriter_GlobalsProvidersTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriter_GlobalsProvidersTests = [
        ("testSeesUIViewDefinition", testSeesUIViewDefinition),
    ]
}

extension SwiftRewriter_IntentionPassHistoryTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriter_IntentionPassHistoryTests = [
        ("testCFilesHistoryTracking", testCFilesHistoryTracking),
        ("testPrintIntentionHistory", testPrintIntentionHistory),
    ]
}

extension SwiftRewriter_IntentionPassTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriter_IntentionPassTests = [
        ("testIntentionPassHasExpressionTypesPreResolved", testIntentionPassHasExpressionTypesPreResolved),
    ]
}

extension SwiftRewriter_MultiFilesTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriter_MultiFilesTests = [
        ("testAvoidEmittingHeaderWhenImplementationExists", testAvoidEmittingHeaderWhenImplementationExists),
        ("testChainCallRespondsToSelectorWithReproCase", testChainCallRespondsToSelectorWithReproCase),
        ("testClassCategory", testClassCategory),
        ("testEmittingHeaderWhenMissingImplementation", testEmittingHeaderWhenMissingImplementation),
        ("testHandleMultifileTypesInheritingFromTypesDefinedInGlobalProviders", testHandleMultifileTypesInheritingFromTypesDefinedInGlobalProviders),
        ("testMergeAndKeepNullabilityDefinitions", testMergeAndKeepNullabilityDefinitions),
        ("testMergeNullabilityOfBlockTypes", testMergeNullabilityOfBlockTypes),
        ("testMergeNullabilityOfExternGlobals", testMergeNullabilityOfExternGlobals),
        ("testMergePropertyConformanceWithMethodInImplementation", testMergePropertyConformanceWithMethodInImplementation),
        ("testMergePropertyConformanceWithMethodInImplementationSynergy", testMergePropertyConformanceWithMethodInImplementationSynergy),
        ("testMergeStructsFromHeaderAndImplementation", testMergeStructsFromHeaderAndImplementation),
        ("testMergingCategoriesTakeCategoryNameInConsideration", testMergingCategoriesTakeCategoryNameInConsideration),
        ("testPreserversAssumesNonnullContextAfterMovingDeclarationsFromHeaderToImplementation", testPreserversAssumesNonnullContextAfterMovingDeclarationsFromHeaderToImplementation),
        ("testProcessAssumeNonnullAcrossFiles", testProcessAssumeNonnullAcrossFiles),
        ("testProtocolConformanceHandling", testProtocolConformanceHandling),
        ("testReadmeSampleMerge", testReadmeSampleMerge),
        ("testRespectsOrderingOfImplementation", testRespectsOrderingOfImplementation),
        ("testTypeLookupsHappenAfterAllSourceCodeIsParsed", testTypeLookupsHappenAfterAllSourceCodeIsParsed),
    ]
}

extension SwiftRewriter_SourcePreprocessor {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriter_SourcePreprocessor = [
        ("testPreprocessorIsInvokedBeforeParsing", testPreprocessorIsInvokedBeforeParsing),
    ]
}

extension SwiftRewriter_StmtTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriter_StmtTests = [
        ("testArrayLiterals", testArrayLiterals),
        ("testAssignmentOperation", testAssignmentOperation),
        ("testAutoreleasePoolStatement", testAutoreleasePoolStatement),
        ("testBlockLiteral", testBlockLiteral),
        ("testBracelessIfElseStatement", testBracelessIfElseStatement),
        ("testBracelessIfWithinIf", testBracelessIfWithinIf),
        ("testContinueBreakStatements", testContinueBreakStatements),
        ("testDictionaryLiterals", testDictionaryLiterals),
        ("testDoWhileStatement", testDoWhileStatement),
        ("testElseStatement", testElseStatement),
        ("testEmitSizeOf", testEmitSizeOf),
        ("testEmitSizeOfForKnownTypes", testEmitSizeOfForKnownTypes),
        ("testEmitTypeCast", testEmitTypeCast),
        ("testFloatLiteral", testFloatLiteral),
        ("testForInStatement", testForInStatement),
        ("testForStatement", testForStatement),
        ("testForStatementWithArrayCount", testForStatementWithArrayCount),
        ("testForStatementWithNonConstantCount", testForStatementWithNonConstantCount),
        ("testForStatementWithNonConstantCountModifiedWithinLoop", testForStatementWithNonConstantCountModifiedWithinLoop),
        ("testForStatementWithNonInitializerStatement", testForStatementWithNonInitializerStatement),
        ("testForStatementWithNonLiteralCount", testForStatementWithNonLiteralCount),
        ("testFreeFunctionCall", testFreeFunctionCall),
        ("testIfElseStatement", testIfElseStatement),
        ("testIfStatement", testIfStatement),
        ("testIfStatementWithExpressions", testIfStatementWithExpressions),
        ("testKeepVarTypePatternsOnNumericTypes", testKeepVarTypePatternsOnNumericTypes),
        ("testKeepVarTypePatternsOnUpcastings", testKeepVarTypePatternsOnUpcastings),
        ("testLabeledStatement", testLabeledStatement),
        ("testLabeledStatementNested", testLabeledStatementNested),
        ("testMemberAccess", testMemberAccess),
        ("testMultipleVarDeclarationInSameStatement", testMultipleVarDeclarationInSameStatement),
        ("testParseBlockVarDeclaration", testParseBlockVarDeclaration),
        ("testParseUnusedVarDeclaration", testParseUnusedVarDeclaration),
        ("testPrefixAndPostfixIncrementAndDecrement", testPrefixAndPostfixIncrementAndDecrement),
        ("testReturnStatement", testReturnStatement),
        ("testSingleBlockArgument", testSingleBlockArgument),
        ("testSingleSynchronizedStatement", testSingleSynchronizedStatement),
        ("testStringLiteral", testStringLiteral),
        ("testSubscription", testSubscription),
        ("testSwitchStatement", testSwitchStatement),
        ("testSwitchStatementAvoidFallthroghIfLastStatementIsUnconditionalJump", testSwitchStatementAvoidFallthroghIfLastStatementIsUnconditionalJump),
        ("testSwitchStatementWithCompoundStatementCases", testSwitchStatementWithCompoundStatementCases),
        ("testSwitchStatementWithFallthroughCases", testSwitchStatementWithFallthroughCases),
        ("testSynchronizedStatement", testSynchronizedStatement),
        ("testTernaryExpression", testTernaryExpression),
        ("testTranslateBinaryExpression", testTranslateBinaryExpression),
        ("testTranslateChainedBinaryExpression", testTranslateChainedBinaryExpression),
        ("testTranslateParenthesizedExpression", testTranslateParenthesizedExpression),
        ("testTranslateSingleSelectorMessage", testTranslateSingleSelectorMessage),
        ("testTranslateTwoSelectorMessage", testTranslateTwoSelectorMessage),
        ("testUnaryOperator", testUnaryOperator),
        ("testVarDeclaration", testVarDeclaration),
        ("testVarDeclarationOmitsTypeOnLocalWithInitialValueMatchingLiteralType", testVarDeclarationOmitsTypeOnLocalWithInitialValueMatchingLiteralType),
        ("testWeakModifier", testWeakModifier),
        ("testWhileStatement", testWhileStatement),
    ]
}

extension SwiftRewriter_ThreadingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriter_ThreadingTests = [
        ("testMultiThreadingStability", testMultiThreadingStability),
    ]
}

extension SwiftRewriter_TypingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftRewriter_TypingTests = [
        ("testAssignImplicitlyUnwrappedOptionalToLocalVariableEscalatesToOptional", testAssignImplicitlyUnwrappedOptionalToLocalVariableEscalatesToOptional),
        ("testBasicOverloadResolution", testBasicOverloadResolution),
        ("testBlockInvocationArgumentIntrinsics", testBlockInvocationArgumentIntrinsics),
        ("testBlockInvocationRetainsDefinedLocalsWithinScope", testBlockInvocationRetainsDefinedLocalsWithinScope),
        ("testCapturingLocalsInBlocksFromOuterScopes", testCapturingLocalsInBlocksFromOuterScopes),
        ("testCastTyping", testCastTyping),
        ("testChainCallRespondsToSelector", testChainCallRespondsToSelector),
        ("testChainedOptionalAccessMethodCall", testChainedOptionalAccessMethodCall),
        ("testChainedOptionalAccessMethodCall2", testChainedOptionalAccessMethodCall2),
        ("testCLibOverloadResolution", testCLibOverloadResolution),
        ("testCreateNonOptionalLocalsWhenRHSInitializerIsNonOptional", testCreateNonOptionalLocalsWhenRHSInitializerIsNonOptional),
        ("testCustomInitClass", testCustomInitClass),
        ("testExpressionWithinBracelessIfStatement", testExpressionWithinBracelessIfStatement),
        ("testExtensionOfGlobalClass", testExtensionOfGlobalClass),
        ("testForStatementIterator", testForStatementIterator),
        ("testIntrinsicsExposeClassInstanceProperties", testIntrinsicsExposeClassInstanceProperties),
        ("testIntrinsicsExposeMethodParameters", testIntrinsicsExposeMethodParameters),
        ("testIntrinsicsForSetterCustomNewValueName", testIntrinsicsForSetterCustomNewValueName),
        ("testIntrinsicsForSetterWithDefaultNewValueName", testIntrinsicsForSetterWithDefaultNewValueName),
        ("testIntrinsicsFromMethodParameter", testIntrinsicsFromMethodParameter),
        ("testLocalVariableDeclarationInitializedTransmitsNullabilityFromRightHandSide", testLocalVariableDeclarationInitializedTransmitsNullabilityFromRightHandSide),
        ("testLocalVariableDeclarationInitializedTransmitsNullabilityFromRightHandSideWithSubclassing", testLocalVariableDeclarationInitializedTransmitsNullabilityFromRightHandSideWithSubclassing),
        ("testLookThroughProtocolConformances", testLookThroughProtocolConformances),
        ("testMessageClassSelf", testMessageClassSelf),
        ("testMessageSelf", testMessageSelf),
        ("testOptionalProtocolInvocationOptionalAccess", testOptionalProtocolInvocationOptionalAccess),
        ("testOutOfOrderTypeResolving", testOutOfOrderTypeResolving),
        ("testOverloadResolution", testOverloadResolution),
        ("testPropertyResolutionLooksThroughNullability", testPropertyResolutionLooksThroughNullability),
        ("testRewriteDeepNestedTransformations", testRewriteDeepNestedTransformations),
        ("testSelfPropertyFetch", testSelfPropertyFetch),
        ("testSelfSuperInitInClassMethod", testSelfSuperInitInClassMethod),
        ("testSelfSuperTypeInClassMethodsPointsToMetatype", testSelfSuperTypeInClassMethodsPointsToMetatype),
        ("testSelfSuperTypeInInstanceMethodsPointsToSelfInstance", testSelfSuperTypeInInstanceMethodsPointsToSelfInstance),
        ("testSelfSuperTypeInPropertySynthesizedGetterAndSetterBody", testSelfSuperTypeInPropertySynthesizedGetterAndSetterBody),
        ("testTypeLookupInFoundationType", testTypeLookupInFoundationType),
        ("testTypeLookupIntoComposedProtocols", testTypeLookupIntoComposedProtocols),
        ("testTypingInGlobalFunction", testTypingInGlobalFunction),
        ("testVariableDeclarationCascadesTypeOfInitialExpression", testVariableDeclarationCascadesTypeOfInitialExpression),
        ("testVisibilityOfGlobalElements", testVisibilityOfGlobalElements),
    ]
}

extension SwiftStatementASTReaderTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftStatementASTReaderTests = [
        ("testAutomaticSwitchFallthrough", testAutomaticSwitchFallthrough),
        ("testAutotypeWeakDefinition", testAutotypeWeakDefinition),
        ("testBlockDeclaration", testBlockDeclaration),
        ("testDeclaration", testDeclaration),
        ("testDoWhile", testDoWhile),
        ("testExpressions", testExpressions),
        ("testFor", testFor),
        ("testForConvertingToWhile", testForConvertingToWhile),
        ("testForIn", testForIn),
        ("testIfStatement", testIfStatement),
        ("testLabeledStatement", testLabeledStatement),
        ("testSwitch", testSwitch),
        ("testWeakNonPointerDefinition", testWeakNonPointerDefinition),
        ("testWhile", testWhile),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ASTRewriterPassTests.__allTests__ASTRewriterPassTests),
        testCase(IntentionCollectorTests.__allTests__IntentionCollectorTests),
        testCase(PropertyMergeIntentionPassTests.__allTests__PropertyMergeIntentionPassTests),
        testCase(SwiftASTReaderContextTests.__allTests__SwiftASTReaderContextTests),
        testCase(SwiftExprASTReaderTests.__allTests__SwiftExprASTReaderTests),
        testCase(SwiftMethodSignatureGenTests.__allTests__SwiftMethodSignatureGenTests),
        testCase(SwiftOperatorTests.__allTests__SwiftOperatorTests),
        testCase(SwiftRewriterJobTests.__allTests__SwiftRewriterJobTests),
        testCase(SwiftRewriterNullabilityTests.__allTests__SwiftRewriterNullabilityTests),
        testCase(SwiftRewriterTests.__allTests__SwiftRewriterTests),
        testCase(SwiftRewriterTests_Crashers.__allTests__SwiftRewriterTests_Crashers),
        testCase(SwiftRewriter_GlobalsProvidersTests.__allTests__SwiftRewriter_GlobalsProvidersTests),
        testCase(SwiftRewriter_IntentionPassHistoryTests.__allTests__SwiftRewriter_IntentionPassHistoryTests),
        testCase(SwiftRewriter_IntentionPassTests.__allTests__SwiftRewriter_IntentionPassTests),
        testCase(SwiftRewriter_MultiFilesTests.__allTests__SwiftRewriter_MultiFilesTests),
        testCase(SwiftRewriter_SourcePreprocessor.__allTests__SwiftRewriter_SourcePreprocessor),
        testCase(SwiftRewriter_StmtTests.__allTests__SwiftRewriter_StmtTests),
        testCase(SwiftRewriter_ThreadingTests.__allTests__SwiftRewriter_ThreadingTests),
        testCase(SwiftRewriter_TypingTests.__allTests__SwiftRewriter_TypingTests),
        testCase(SwiftStatementASTReaderTests.__allTests__SwiftStatementASTReaderTests),
    ]
}
#endif
