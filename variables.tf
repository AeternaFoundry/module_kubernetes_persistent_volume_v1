variable "persistent_volume_v1s" {
  description = <<EOT
Map of persistent_volume_v1s, attributes below
Required:
    - metadata (block):
        - annotations (optional)
        - labels (optional)
        - name (optional)
    - spec (block):
        - access_modes (required)
        - capacity (required)
        - claim_ref (optional, block):
            - name (required)
            - namespace (optional)
        - mount_options (optional)
        - node_affinity (optional, block):
            - required (optional, block):
                - node_selector_term (required, block):
                    - match_expressions (optional, block):
                        - key (required)
                        - operator (required)
                        - values (optional)
                    - match_fields (optional, block):
                        - key (required)
                        - operator (required)
                        - values (optional)
        - persistent_volume_reclaim_policy (optional)
        - persistent_volume_source (required, block):
            - aws_elastic_block_store (optional, block):
                - fs_type (optional)
                - partition (optional)
                - read_only (optional)
                - volume_id (required)
            - azure_disk (optional, block):
                - caching_mode (required)
                - data_disk_uri (required)
                - disk_name (required)
                - fs_type (optional)
                - kind (optional)
                - read_only (optional)
            - azure_file (optional, block):
                - read_only (optional)
                - secret_name (required)
                - secret_namespace (optional)
                - share_name (required)
            - ceph_fs (optional, block):
                - monitors (required)
                - path (optional)
                - read_only (optional)
                - secret_file (optional)
                - secret_ref (optional, block):
                    - name (optional)
                    - namespace (optional)
                - user (optional)
            - cinder (optional, block):
                - fs_type (optional)
                - read_only (optional)
                - volume_id (required)
            - csi (optional, block):
                - controller_expand_secret_ref (optional, block):
                    - name (optional)
                    - namespace (optional)
                - controller_publish_secret_ref (optional, block):
                    - name (optional)
                    - namespace (optional)
                - driver (required)
                - fs_type (optional)
                - node_publish_secret_ref (optional, block):
                    - name (optional)
                    - namespace (optional)
                - node_stage_secret_ref (optional, block):
                    - name (optional)
                    - namespace (optional)
                - read_only (optional)
                - volume_attributes (optional)
                - volume_handle (required)
            - fc (optional, block):
                - fs_type (optional)
                - lun (required)
                - read_only (optional)
                - target_ww_ns (required)
            - flex_volume (optional, block):
                - driver (required)
                - fs_type (optional)
                - options (optional)
                - read_only (optional)
                - secret_ref (optional, block):
                    - name (optional)
                    - namespace (optional)
            - flocker (optional, block):
                - dataset_name (optional)
                - dataset_uuid (optional)
            - gce_persistent_disk (optional, block):
                - fs_type (optional)
                - partition (optional)
                - pd_name (required)
                - read_only (optional)
            - glusterfs (optional, block):
                - endpoints_name (required)
                - path (required)
                - read_only (optional)
            - host_path (optional, block):
                - path (optional)
                - type (optional)
            - iscsi (optional, block):
                - fs_type (optional)
                - iqn (required)
                - iscsi_interface (optional)
                - lun (optional)
                - read_only (optional)
                - target_portal (required)
            - local (optional, block):
                - path (optional)
            - nfs (optional, block):
                - path (required)
                - read_only (optional)
                - server (required)
            - photon_persistent_disk (optional, block):
                - fs_type (optional)
                - pd_id (required)
            - quobyte (optional, block):
                - group (optional)
                - read_only (optional)
                - registry (required)
                - user (optional)
                - volume (required)
            - rbd (optional, block):
                - ceph_monitors (required)
                - fs_type (optional)
                - keyring (optional)
                - rados_user (optional)
                - rbd_image (required)
                - rbd_pool (optional)
                - read_only (optional)
                - secret_ref (optional, block):
                    - name (optional)
                    - namespace (optional)
            - vsphere_volume (optional, block):
                - fs_type (optional)
                - volume_path (required)
        - storage_class_name (optional)
        - volume_mode (optional)
Optional:
    - timeouts (block):
        - create (optional)
EOT

  type = map(object({
    metadata = object({
      annotations = optional(map(string))
      labels      = optional(map(string))
      name        = optional(string)
    })
    spec = list(object({
      access_modes = set(string)
      capacity     = map(string)
      claim_ref = optional(object({
        name      = string
        namespace = optional(string)
      }))
      mount_options = optional(set(string))
      node_affinity = optional(object({
        required = optional(object({
          node_selector_term = list(object({
            match_expressions = optional(list(object({
              key      = string
              operator = string
              values   = optional(set(string))
            })))
            match_fields = optional(list(object({
              key      = string
              operator = string
              values   = optional(set(string))
            })))
          }))
        }))
      }))
      persistent_volume_reclaim_policy = optional(string)
      persistent_volume_source = object({
        aws_elastic_block_store = optional(object({
          fs_type   = optional(string)
          partition = optional(number)
          read_only = optional(bool)
          volume_id = string
        }))
        azure_disk = optional(object({
          caching_mode  = string
          data_disk_uri = string
          disk_name     = string
          fs_type       = optional(string)
          kind          = optional(string)
          read_only     = optional(bool)
        }))
        azure_file = optional(object({
          read_only        = optional(bool)
          secret_name      = string
          secret_namespace = optional(string)
          share_name       = string
        }))
        ceph_fs = optional(object({
          monitors    = set(string)
          path        = optional(string)
          read_only   = optional(bool)
          secret_file = optional(string)
          secret_ref = optional(object({
            name      = optional(string)
            namespace = optional(string)
          }))
          user = optional(string)
        }))
        cinder = optional(object({
          fs_type   = optional(string)
          read_only = optional(bool)
          volume_id = string
        }))
        csi = optional(object({
          controller_expand_secret_ref = optional(object({
            name      = optional(string)
            namespace = optional(string)
          }))
          controller_publish_secret_ref = optional(object({
            name      = optional(string)
            namespace = optional(string)
          }))
          driver  = string
          fs_type = optional(string)
          node_publish_secret_ref = optional(object({
            name      = optional(string)
            namespace = optional(string)
          }))
          node_stage_secret_ref = optional(object({
            name      = optional(string)
            namespace = optional(string)
          }))
          read_only         = optional(bool)
          volume_attributes = optional(map(string))
          volume_handle     = string
        }))
        fc = optional(object({
          fs_type      = optional(string)
          lun          = number
          read_only    = optional(bool)
          target_ww_ns = set(string)
        }))
        flex_volume = optional(object({
          driver    = string
          fs_type   = optional(string)
          options   = optional(map(string))
          read_only = optional(bool)
          secret_ref = optional(object({
            name      = optional(string)
            namespace = optional(string)
          }))
        }))
        flocker = optional(object({
          dataset_name = optional(string)
          dataset_uuid = optional(string)
        }))
        gce_persistent_disk = optional(object({
          fs_type   = optional(string)
          partition = optional(number)
          pd_name   = string
          read_only = optional(bool)
        }))
        glusterfs = optional(object({
          endpoints_name = string
          path           = string
          read_only      = optional(bool)
        }))
        host_path = optional(object({
          path = optional(string)
          type = optional(string)
        }))
        iscsi = optional(object({
          fs_type         = optional(string)
          iqn             = string
          iscsi_interface = optional(string)
          lun             = optional(number)
          read_only       = optional(bool)
          target_portal   = string
        }))
        local = optional(object({
          path = optional(string)
        }))
        nfs = optional(object({
          path      = string
          read_only = optional(bool)
          server    = string
        }))
        photon_persistent_disk = optional(object({
          fs_type = optional(string)
          pd_id   = string
        }))
        quobyte = optional(object({
          group     = optional(string)
          read_only = optional(bool)
          registry  = string
          user      = optional(string)
          volume    = string
        }))
        rbd = optional(object({
          ceph_monitors = set(string)
          fs_type       = optional(string)
          keyring       = optional(string)
          rados_user    = optional(string)
          rbd_image     = string
          rbd_pool      = optional(string)
          read_only     = optional(bool)
          secret_ref = optional(object({
            name      = optional(string)
            namespace = optional(string)
          }))
        }))
        vsphere_volume = optional(object({
          fs_type     = optional(string)
          volume_path = string
        }))
      })
      storage_class_name = optional(string)
      volume_mode        = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.persistent_volume_v1s : (
        length(v.spec) >= 1
      )
    ])
    error_message = "Each spec list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.persistent_volume_v1s : (
        alltrue([for item in v.spec : (item.node_affinity == null || (item.node_affinity.required == null || (length(item.node_affinity.required.node_selector_term) >= 1)))])
      )
    ])
    error_message = "Each node_selector_term list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.persistent_volume_v1s : (
        alltrue([for item in v.spec : (alltrue([for x in item.access_modes : contains(["ReadWriteOnce", "ReadOnlyMany", "ReadWriteMany", "ReadWriteOncePod"], x)]))])
      )
    ])
    error_message = "must be one of: \"ReadWriteOnce\", \"ReadOnlyMany\", \"ReadWriteMany\", \"ReadWriteOncePod\""
  }
  validation {
    condition = alltrue([
      for k, v in var.persistent_volume_v1s : (
        alltrue([for item in v.spec : (item.persistent_volume_reclaim_policy == null || (contains(["Recycle", "Delete", "Retain"], item.persistent_volume_reclaim_policy)))])
      )
    ])
    error_message = "must be one of: \"Recycle\", \"Delete\", \"Retain\""
  }
  validation {
    condition = alltrue([
      for k, v in var.persistent_volume_v1s : (
        alltrue([for item in v.spec : (item.volume_mode == null || (contains(["Block", "Filesystem"], item.volume_mode)))])
      )
    ])
    error_message = "must be one of: \"Block\", \"Filesystem\""
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

