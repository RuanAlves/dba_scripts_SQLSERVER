# Notas de Atualização - S7ERP

### 11.20I (30/12/2020)

#### Melhoria

 * **Rotina 609**: Criado novo campo "Vl. Tot. Títulos" na Dialog do detalhamento do Desdobramento, que se encontra na aba "Destino" 
 * **Rotina 201**: Implementada usabilidade onde somente deve aparecer os CST IPI, CST PIS, e CST COFINS de Entrada.
 * **Rotina 113**: Implementada validação que não permite o usuário desmarcar opção "Usa Lote", se o produto selecionado estiver com quantidade diferente de ZERO.

 #### Correção
 
 * Improvement: Improve some English strings (Issue #149, PR #571 and #576 by @jsoberg)
 * Improvement: Don't automatically backup when updating last used or when moving cards
 * Improvement: Enable the "append date to backups" option by default
 * Improvement: Strip issuer from the label when adding via URL/QR code (Issue #551, PR #560 by @shivasheeshyadav)
 * Improvement: Remove the "new backup format warning" (has been there long enough)
 * Improvement: Show requirements for auto backups in the settings (Issue #492)
 * Improvement: Fix some accessibility issues (Issue #498)
 * Improvement: Toggle show/hide of a password confirmation field together with the password field (Issue #638, PR #641 by @jsoberg)
 * Improvement: Decoding of secrets with an invalid Base32 encoding (Issue #600)
 * Correção de Bug: Make the automatic thumbnail selection case insensitive (Issue #564)
 * Correção: Validate Integer input for counter, digits and period (Issue #569, PR #570 by @jsoberg)
 * Bug fix: Visibility of the password confirmation field (Issue #580, PR #582 by @jsoberg)
 * Bug fix: Crash when clicking on an entry multiple times (Issue #631, PR #634 by @jsoberg)
 * Bug fix: Crash during settings changes (Issue #639, PR #640 by @jsoberg)
 * Bug fix: Don't use regionalized language codes (Issue #567)
 * Bug fix: Report backup failure correctly (Issue #671)
 * Internal: Update Gradle, build tools and dependencies
 * Internal: Min API Level set to 22 (Lollipop	5.1)
 * Internal: Refactoring and reducing build warnings
 * Thumbnails: Lots of new ones (thanks to all contributors)

