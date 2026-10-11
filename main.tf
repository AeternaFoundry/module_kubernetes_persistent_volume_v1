resource "kubernetes_persistent_volume_v1" "persistent_volume_v1s" {
  for_each = var.persistent_volume_v1s


  metadata {
    annotations = each.value.metadata.annotations
    labels      = each.value.metadata.labels
    name        = each.value.metadata.name
  }

  dynamic "spec" {
    for_each = each.value.spec
    content {
      access_modes = spec.value.access_modes
      capacity     = spec.value.capacity
      dynamic "claim_ref" {
        for_each = spec.value.claim_ref != null ? [spec.value.claim_ref] : []
        content {
          name      = claim_ref.value.name
          namespace = claim_ref.value.namespace
        }
      }
      mount_options = spec.value.mount_options
      dynamic "node_affinity" {
        for_each = spec.value.node_affinity != null ? [spec.value.node_affinity] : []
        content {
          dynamic "required" {
            for_each = node_affinity.value.required != null ? [node_affinity.value.required] : []
            content {
              dynamic "node_selector_term" {
                for_each = required.value.node_selector_term
                content {
                  dynamic "match_expressions" {
                    for_each = node_selector_term.value.match_expressions != null ? node_selector_term.value.match_expressions : []
                    content {
                      key      = match_expressions.value.key
                      operator = match_expressions.value.operator
                      values   = match_expressions.value.values
                    }
                  }
                  dynamic "match_fields" {
                    for_each = node_selector_term.value.match_fields != null ? node_selector_term.value.match_fields : []
                    content {
                      key      = match_fields.value.key
                      operator = match_fields.value.operator
                      values   = match_fields.value.values
                    }
                  }
                }
              }
            }
          }
        }
      }
      persistent_volume_reclaim_policy = spec.value.persistent_volume_reclaim_policy
      persistent_volume_source {
        dynamic "aws_elastic_block_store" {
          for_each = spec.value.persistent_volume_source.aws_elastic_block_store != null ? [spec.value.persistent_volume_source.aws_elastic_block_store] : []
          content {
            fs_type   = aws_elastic_block_store.value.fs_type
            partition = aws_elastic_block_store.value.partition
            read_only = aws_elastic_block_store.value.read_only
            volume_id = aws_elastic_block_store.value.volume_id
          }
        }
        dynamic "azure_disk" {
          for_each = spec.value.persistent_volume_source.azure_disk != null ? [spec.value.persistent_volume_source.azure_disk] : []
          content {
            caching_mode  = azure_disk.value.caching_mode
            data_disk_uri = azure_disk.value.data_disk_uri
            disk_name     = azure_disk.value.disk_name
            fs_type       = azure_disk.value.fs_type
            kind          = azure_disk.value.kind
            read_only     = azure_disk.value.read_only
          }
        }
        dynamic "azure_file" {
          for_each = spec.value.persistent_volume_source.azure_file != null ? [spec.value.persistent_volume_source.azure_file] : []
          content {
            read_only        = azure_file.value.read_only
            secret_name      = azure_file.value.secret_name
            secret_namespace = azure_file.value.secret_namespace
            share_name       = azure_file.value.share_name
          }
        }
        dynamic "ceph_fs" {
          for_each = spec.value.persistent_volume_source.ceph_fs != null ? [spec.value.persistent_volume_source.ceph_fs] : []
          content {
            monitors    = ceph_fs.value.monitors
            path        = ceph_fs.value.path
            read_only   = ceph_fs.value.read_only
            secret_file = ceph_fs.value.secret_file
            dynamic "secret_ref" {
              for_each = ceph_fs.value.secret_ref != null ? [ceph_fs.value.secret_ref] : []
              content {
                name      = secret_ref.value.name
                namespace = secret_ref.value.namespace
              }
            }
            user = ceph_fs.value.user
          }
        }
        dynamic "cinder" {
          for_each = spec.value.persistent_volume_source.cinder != null ? [spec.value.persistent_volume_source.cinder] : []
          content {
            fs_type   = cinder.value.fs_type
            read_only = cinder.value.read_only
            volume_id = cinder.value.volume_id
          }
        }
        dynamic "csi" {
          for_each = spec.value.persistent_volume_source.csi != null ? [spec.value.persistent_volume_source.csi] : []
          content {
            dynamic "controller_expand_secret_ref" {
              for_each = csi.value.controller_expand_secret_ref != null ? [csi.value.controller_expand_secret_ref] : []
              content {
                name      = controller_expand_secret_ref.value.name
                namespace = controller_expand_secret_ref.value.namespace
              }
            }
            dynamic "controller_publish_secret_ref" {
              for_each = csi.value.controller_publish_secret_ref != null ? [csi.value.controller_publish_secret_ref] : []
              content {
                name      = controller_publish_secret_ref.value.name
                namespace = controller_publish_secret_ref.value.namespace
              }
            }
            driver  = csi.value.driver
            fs_type = csi.value.fs_type
            dynamic "node_publish_secret_ref" {
              for_each = csi.value.node_publish_secret_ref != null ? [csi.value.node_publish_secret_ref] : []
              content {
                name      = node_publish_secret_ref.value.name
                namespace = node_publish_secret_ref.value.namespace
              }
            }
            dynamic "node_stage_secret_ref" {
              for_each = csi.value.node_stage_secret_ref != null ? [csi.value.node_stage_secret_ref] : []
              content {
                name      = node_stage_secret_ref.value.name
                namespace = node_stage_secret_ref.value.namespace
              }
            }
            read_only         = csi.value.read_only
            volume_attributes = csi.value.volume_attributes
            volume_handle     = csi.value.volume_handle
          }
        }
        dynamic "fc" {
          for_each = spec.value.persistent_volume_source.fc != null ? [spec.value.persistent_volume_source.fc] : []
          content {
            fs_type      = fc.value.fs_type
            lun          = fc.value.lun
            read_only    = fc.value.read_only
            target_ww_ns = fc.value.target_ww_ns
          }
        }
        dynamic "flex_volume" {
          for_each = spec.value.persistent_volume_source.flex_volume != null ? [spec.value.persistent_volume_source.flex_volume] : []
          content {
            driver    = flex_volume.value.driver
            fs_type   = flex_volume.value.fs_type
            options   = flex_volume.value.options
            read_only = flex_volume.value.read_only
            dynamic "secret_ref" {
              for_each = flex_volume.value.secret_ref != null ? [flex_volume.value.secret_ref] : []
              content {
                name      = secret_ref.value.name
                namespace = secret_ref.value.namespace
              }
            }
          }
        }
        dynamic "flocker" {
          for_each = spec.value.persistent_volume_source.flocker != null ? [spec.value.persistent_volume_source.flocker] : []
          content {
            dataset_name = flocker.value.dataset_name
            dataset_uuid = flocker.value.dataset_uuid
          }
        }
        dynamic "gce_persistent_disk" {
          for_each = spec.value.persistent_volume_source.gce_persistent_disk != null ? [spec.value.persistent_volume_source.gce_persistent_disk] : []
          content {
            fs_type   = gce_persistent_disk.value.fs_type
            partition = gce_persistent_disk.value.partition
            pd_name   = gce_persistent_disk.value.pd_name
            read_only = gce_persistent_disk.value.read_only
          }
        }
        dynamic "glusterfs" {
          for_each = spec.value.persistent_volume_source.glusterfs != null ? [spec.value.persistent_volume_source.glusterfs] : []
          content {
            endpoints_name = glusterfs.value.endpoints_name
            path           = glusterfs.value.path
            read_only      = glusterfs.value.read_only
          }
        }
        dynamic "host_path" {
          for_each = spec.value.persistent_volume_source.host_path != null ? [spec.value.persistent_volume_source.host_path] : []
          content {
            path = host_path.value.path
            type = host_path.value.type
          }
        }
        dynamic "iscsi" {
          for_each = spec.value.persistent_volume_source.iscsi != null ? [spec.value.persistent_volume_source.iscsi] : []
          content {
            fs_type         = iscsi.value.fs_type
            iqn             = iscsi.value.iqn
            iscsi_interface = iscsi.value.iscsi_interface
            lun             = iscsi.value.lun
            read_only       = iscsi.value.read_only
            target_portal   = iscsi.value.target_portal
          }
        }
        dynamic "local" {
          for_each = spec.value.persistent_volume_source.local != null ? [spec.value.persistent_volume_source.local] : []
          content {
            path = local.value.path
          }
        }
        dynamic "nfs" {
          for_each = spec.value.persistent_volume_source.nfs != null ? [spec.value.persistent_volume_source.nfs] : []
          content {
            path      = nfs.value.path
            read_only = nfs.value.read_only
            server    = nfs.value.server
          }
        }
        dynamic "photon_persistent_disk" {
          for_each = spec.value.persistent_volume_source.photon_persistent_disk != null ? [spec.value.persistent_volume_source.photon_persistent_disk] : []
          content {
            fs_type = photon_persistent_disk.value.fs_type
            pd_id   = photon_persistent_disk.value.pd_id
          }
        }
        dynamic "quobyte" {
          for_each = spec.value.persistent_volume_source.quobyte != null ? [spec.value.persistent_volume_source.quobyte] : []
          content {
            group     = quobyte.value.group
            read_only = quobyte.value.read_only
            registry  = quobyte.value.registry
            user      = quobyte.value.user
            volume    = quobyte.value.volume
          }
        }
        dynamic "rbd" {
          for_each = spec.value.persistent_volume_source.rbd != null ? [spec.value.persistent_volume_source.rbd] : []
          content {
            ceph_monitors = rbd.value.ceph_monitors
            fs_type       = rbd.value.fs_type
            keyring       = rbd.value.keyring
            rados_user    = rbd.value.rados_user
            rbd_image     = rbd.value.rbd_image
            rbd_pool      = rbd.value.rbd_pool
            read_only     = rbd.value.read_only
            dynamic "secret_ref" {
              for_each = rbd.value.secret_ref != null ? [rbd.value.secret_ref] : []
              content {
                name      = secret_ref.value.name
                namespace = secret_ref.value.namespace
              }
            }
          }
        }
        dynamic "vsphere_volume" {
          for_each = spec.value.persistent_volume_source.vsphere_volume != null ? [spec.value.persistent_volume_source.vsphere_volume] : []
          content {
            fs_type     = vsphere_volume.value.fs_type
            volume_path = vsphere_volume.value.volume_path
          }
        }
      }
      storage_class_name = spec.value.storage_class_name
      volume_mode        = spec.value.volume_mode
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
    }
  }
}

