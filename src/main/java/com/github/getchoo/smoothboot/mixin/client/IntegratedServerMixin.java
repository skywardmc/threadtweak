package com.github.getchoo.smoothboot.mixin.client;

import com.github.getchoo.smoothboot.SmoothBoot;
import net.minecraft.client.MinecraftClient;
import net.minecraft.resource.ResourcePackManager;
import net.minecraft.server.SaveLoader;
import net.minecraft.server.integrated.IntegratedServer;
import net.minecraft.util.ApiServices;
import net.minecraft.world.chunk.ChunkLoadProgress;
import net.minecraft.world.level.storage.LevelStorage;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

@Mixin(IntegratedServer.class)
public class IntegratedServerMixin {
    @Inject(method = "<init>", at = @At("RETURN"))
    public void onInit(Thread serverThread, MinecraftClient client, LevelStorage.Session session, ResourcePackManager dataPackManager, SaveLoader saveLoader, ApiServices apiServices, ChunkLoadProgress chunkLoadProgress, CallbackInfo ci) {
        serverThread.setPriority(SmoothBoot.config.threadPriority.integratedServer);
        SmoothBoot.LOGGER.debug("Initialized integrated server thread");
    }
}
