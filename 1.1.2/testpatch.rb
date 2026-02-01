# Patch: Surf prompt text override
return if defined?(Patch_SurfPrompt_Once)
Patch_SurfPrompt_Once = true

def pbSurf
  return false if defined?(SurfPromptSuppressor) &&
                  SurfPromptSuppressor.suppress_for_facing_tile?
  return false if !$game_player.can_ride_vehicle_with_follower?
  move = :SURF
  movefinder = $player.get_pokemon_with_move(move)
  if !pbCheckHiddenMoveBadge(Settings::BADGE_FOR_SURF, false) || (!$DEBUG && !movefinder)
    return false
  end
  if $PokemonMap.surfUsed ||
     pbConfirmMessage(_INTL("If you're reading this text, it means Pokemon Echo can now successfully be patched."))
    pbCancelVehicles
    pbHiddenMoveAnimation(movefinder)
    $PokemonMap.surfUsed = true
    surfbgm = GameData::Metadata.get.surf_BGM
    pbCueBGM(surfbgm, 0.5) if surfbgm
    pbStartSurfing
    return true
  end
  return false
end
